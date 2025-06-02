-- Caso 1: Control de disponibilidad de un coach cuando se elimina un horario
--
-- Problema:
-- Cuando se elimina un registro en la tabla schedules (un horario asignado a un coach),
-- el coach podría quedar sin horarios asignados, pero su estado de disponibilidad (availability)
-- sigue siendo "activo". Esto genera inconsistencias, ya que un coach sin horarios no debería estar disponible para nuevos entrenamientos.
--
-- Solución:
-- Crear un disparador que, al eliminar un horario (DELETE en schedules),
-- verifique si el coach asociado tiene más horarios activos. Si no tiene ninguno,
-- actualizar el campo availability del coach a "inactivo".

CREATE OR REPLACE FUNCTION update_coach_availability_after_schedule_delete() 
RETURNS TRIGGER AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM schedules WHERE coach_id = OLD.coach_id
    ) THEN
        UPDATE coaches
        SET availability = 'inactivo'
        WHERE coach_id = OLD.coach_id;
    END IF;
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_coach_availability_after_schedule_delete
AFTER DELETE ON schedules
FOR EACH ROW
EXECUTE FUNCTION update_coach_availability_after_schedule_delete();

-- Caso 2: Evitar pagos duplicados para un mismo programa y cliente
--
-- Problema:
-- Un cliente podría accidentalmente generar múltiples pagos para el mismo programa
-- de entrenamiento (client_training_programs), lo que genera registros duplicados y problemas de facturación.
--
-- Solución:
-- Crear un disparador antes de insertar un pago que verifique si ya existe un pago
-- con estado "pagado" para ese client_training_program_id. Si existe, cancelar la inserción.

CREATE OR REPLACE FUNCTION prevent_duplicate_paid_payments()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM payments 
        WHERE client_training_program_id = NEW.client_training_program_id 
          AND status = 'pagado'
    ) THEN
        RAISE EXCEPTION 'Ya existe un pago pagado para este programa y cliente.';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_prevent_duplicate_paid_payments
BEFORE INSERT ON payments
FOR EACH ROW
EXECUTE FUNCTION prevent_duplicate_paid_payments();

-- Caso 3: Actualizar estado de programa de entrenamiento del cliente al finalizar fecha
--
-- Problema:
-- Los programas de entrenamiento de un cliente (client_training_programs)
-- tienen una fecha de fin (end_date). Cuando la fecha actual supera esta fecha,
-- el estado debería actualizarse automáticamente a "finalizado". De no hacerse,
-- el estado puede quedar como "activo" aunque el programa ya terminó.
--
-- Solución:
-- Crear un disparador que se ejecute periódicamente o al actualizar el
-- programa que revise la fecha de fin y actualice el estado a "finalizado" si la fecha pasó.

CREATE OR REPLACE FUNCTION update_training_program_status()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.end_date IS NOT NULL AND NEW.end_date < CURRENT_TIMESTAMP THEN
        NEW.status := 'finalizado';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_training_program_status
BEFORE UPDATE ON client_training_programs
FOR EACH ROW
EXECUTE FUNCTION update_training_program_status();
