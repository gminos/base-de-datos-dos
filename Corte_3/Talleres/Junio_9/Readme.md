## 🛠️ Restaurar Base de Datos MongoDB con `mongorestore`

Esta guía explica cómo restaurar una base de datos MongoDB desde un respaldo previamente realizado con `mongodump`.

> ⚠️ **IMPORTANTE:**  
> Antes de restaurar, asegúrese de que la base de datos ya esté creada en el servidor de MongoDB.  
> En los ejemplos a continuación, se supone que la base de datos `ayudas_mongo` ya existe.

---

### 📦 Requisitos

- Tener instalado `mongorestore` (parte de `mongodb-tools`).
- Acceso al servidor MongoDB.

### 🔁 Restaurar una base de datos específica

```bash
mongorestore --db <nombre_destino> <ruta_al_respaldo>/<nombre_origen>
```
- Ejemplo practico:

```bash
mongorestore --db ayudas_mongo ayudas.bson
```
---
## Ejemplos de uso
![image](https://github.com/user-attachments/assets/c39bc6a0-c3c7-4323-abab-e572d7c44f6d)

