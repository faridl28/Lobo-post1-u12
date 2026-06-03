# lobo-post1-u12

**Programación Web — Unidad 12: Despliegue y CI/CD**  
**Post-Contenido 1 — Contenedorizar la Aplicación Spring Boot y Desplegar en Railway**  
Estudiante: Farid Lobo | Código: 1152338  
GitHub: github.com/faridl28/lobo-post1-u12

---

## Descripción

Contenedorización del catálogo de productos con Docker multi-stage y despliegue en Railway con PostgreSQL.

---

## URL pública en Railway

**https://lobo-post1-u12-production.up.railway.app**

Verificar salud:
```
GET https://lobo-post1-u12-production.up.railway.app/actuator/health
```

---

## Requisitos locales

- Docker Desktop instalado y en ejecución
- Maven 3.8+
- Java 17+

---

## Construcción y ejecución local

### Solo Docker
```bash
docker build -t catalogo:local .
docker run -p 8080:8080 catalogo:local
```

### Con Docker Compose (app + PostgreSQL)
```bash
docker compose up -d --build
docker compose ps
```

Verificar salud:
```bash
curl http://localhost:8080/actuator/health
```

Detener:
```bash
docker compose down
```

---

## Capturas de pantalla

<img width="921" height="517" alt="image" src="https://github.com/user-attachments/assets/a58d8542-aa0f-47b5-85fa-836413f4cc8c" />
<img width="921" height="478" alt="image" src="https://github.com/user-attachments/assets/0c790aae-a01a-49a0-b913-07da9474e16d" />
<img width="1365" height="706" alt="image" src="https://github.com/user-attachments/assets/15f56cdb-1a97-487a-b3fb-cde609d8bd13" />
<img width="1281" height="649" alt="image" src="https://github.com/user-attachments/assets/19fdf3bf-0788-4edf-8ede-d5cd150dea77" />
<img width="1365" height="599" alt="image" src="https://github.com/user-attachments/assets/46b31835-8c44-4deb-a6f4-814c34253782" />


## Variables de entorno requeridas

| Variable | Descripción | Ejemplo |
|----------|-------------|---------|
| `SPRING_PROFILES_ACTIVE` | Perfil activo | `prod` |
| `DATABASE_URL` | URL JDBC de PostgreSQL | `jdbc:postgresql://host:5432/db` |
| `DB_USER` | Usuario de la base de datos | `appuser` |
| `DB_PASS` | Contraseña de la base de datos | `apppass` |

---

## Endpoints disponibles

| Método | URL | Descripción | Código |
|--------|-----|-------------|--------|
| GET | `/actuator/health` | Estado de la aplicación | 200 |
| POST | `/api/productos` | Crear producto | 201 |
| GET | `/api/productos` | Listar productos activos | 200 |
| GET | `/api/productos/{id}` | Buscar por ID | 200/404 |
| DELETE | `/api/productos/{id}` | Eliminar producto | 204/404 |

---

## Estructura del proyecto

```
lobo-post1-u12/
├── Dockerfile                          ← Multi-stage (JDK builder + JRE prod)
├── .dockerignore
├── docker-compose.yml                  ← App + PostgreSQL
├── pom.xml
├── README.md
└── src/main/resources/
    ├── application.properties          ← Perfil dev (H2, puerto 8080)
    ├── application-prod.properties     ← Perfil prod (PostgreSQL)
    └── logback-spring.xml
```

---

## Commits

1. `feat: Dockerfile multi-stage y .dockerignore`
2. `feat: docker-compose con PostgreSQL y perfil de produccion`
3. `docs: README con instrucciones de despliegue y Railway`
