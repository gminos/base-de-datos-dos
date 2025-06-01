#!/usr/bin/env bash

print_success() {
  echo -e "\e[32m$1\e[0m"
}

print_error() {
  echo -e "\e[31m$1\e[0m"
}

print_info() {
  echo -e "\e[93m$1\e[0m"
}

if ! command -v psql >/dev/null 2>&1; then
  print_error "'psql' no está instalado o no se encuentra en el PATH. Por favor instálalo antes de continuar."
  exit 1
fi

read -rp "Ingrese su usuario de PostgreSQL: " PG_USER
if [[ -z "$PG_USER" ]]; then
  print_error "El nombre de usuario no puede estar vacío."
  exit 1
fi

read -rp "Ingrese el nombre de la base de datos a crear: " DB_NAME
if [[ -z "$DB_NAME" ]]; then
  print_error "El nombre de la base de datos no puede estar vacío."
  exit 1
fi

print_info "Se conectará con el usuario: $PG_USER"
print_info "La base de datos a crear será: $DB_NAME"

if psql -U "$PG_USER" -lqt 2>/dev/null | cut -d \| -f 1 | grep -qw "$DB_NAME"; then
  print_success "La base de datos '$DB_NAME' ya existe. Saliendo..."
  exit 0
fi

if createdb -U "$PG_USER" "$DB_NAME" 2>/dev/null; then
  print_success "Base de datos '$DB_NAME' creada exitosamente."
else
  print_error "Error: No se pudo crear la base de datos '$DB_NAME'."
  exit 1
fi

BACKUP_FILE="respaldo_gimnaso.backup"

if [[ ! -f "$BACKUP_FILE" ]]; then
  print_error "Archivo de respaldo '$BACKUP_FILE' no encontrado."
  exit 1
fi

print_info "Se procederá a restaurar la base de datos desde '$BACKUP_FILE'."
print_info "Es posible que se le solicite la contraseña de PostgreSQL para el usuario '$PG_USER'."

if pg_restore -U "$PG_USER" -d "$DB_NAME" "$BACKUP_FILE" 2>/dev/null; then
  print_success "Restauración completada con éxito."
else
  print_error "Error durante la restauración de la base de datos."
  exit 1
fi
