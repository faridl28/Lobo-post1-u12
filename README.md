# lobo-post1-u12

**Programación Web — Unidad 12: Despliegue y CI/CD**  
**Post-Contenido 1 — Contenedorizar la Aplicación Spring Boot y Desplegar en Railway**  
Estudiante: Farid Lobo | Código: 1152338  
GitHub: github.com/faridl28/lobo-post1-u12

---

## Descripción

Contenedorización del catálogo de productos con Docker multi-stage y despliegue en Railway con PostgreSQL.

---

## Requisitos locales

- Docker Desktop instalado y en ejecución
- Maven 3.8+
- Java 17+

---

## Construcción y ejecución local

### Solo Docker (sin Compose)
```bash
docker build -t catalogo:local .
docker run -p 8080:8080 catalogo:local
```

### Con Docker Compose (app + PostgreSQL)
```bash
docker compose up -d --build
```

Verificar que ambos servicios estén activos:
```bash
docker compose ps
```

Verificar salud de la aplicación:
```bash
curl http://localhost:8080/actuator/health
```

Detener los servicios:
```bash
docker compose down
```

---

## Variables de entorno requeridas

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `SPRING_PROFILES_ACTIVE` | Perfil activo | `prod` |
| `DATABASE_URL` | URL JDBC de PostgreSQL | `jdbc:postgresql://host:5432/db` |
| `DB_USER` | Usuario de la base de datos | `appuser` |
| `DB_PASS` | Contraseña de la base de datos | `apppass` |

---

## Endpoints disponibles

| Método | URL | Descripción |
|--------|-----|-------------|
| GET | `/actuator/health` | Estado de la aplicación |
| POST | `/api/productos` | Crear producto |
| GET | `/api/productos` | Listar productos activos |
| GET | `/api/productos/{id}` | Buscar por ID |
| DELETE | `/api/productos/{id}` | Eliminar producto |

---

## Despliegue en Railway

URL pública: **[pendiente tras despliegue]**

### Pasos realizados
1. Conectar repositorio GitHub a Railway
2. Railway detecta el Dockerfile automáticamente
3. Agregar servicio PostgreSQL desde el panel de Railway
4. Configurar variables de entorno en Railway:
   - `SPRING_PROFILES_ACTIVE=prod`
   - `DATABASE_URL=${{Postgres.DATABASE_URL}}`
   - `DB_USER=${{Postgres.PGUSER}}`
   - `DB_PASS=${{Postgres.PGPASSWORD}}`
5. Generar dominio público en Settings → Networking

---

## Estructura del proyecto

```
lobo-post1-u12/
├── Dockerfile
├── .dockerignore
├── docker-compose.yml
├── pom.xml
├── README.md
└── src/main/resources/
    ├── application.properties          ← perfil dev (H2)
    ├── application-prod.properties     ← perfil prod (PostgreSQL)
    └── logback-spring.xml
```
