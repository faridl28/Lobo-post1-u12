# ── Etapa 1: compilación con Maven ──────────────────────────────────
FROM eclipse-temurin:21-jdk-alpine AS builder
WORKDIR /app

# Instalar Maven
RUN apk add --no-cache maven

# Copiar pom.xml primero para aprovechar la caché de capas de Docker
COPY pom.xml .
RUN mvn dependency:go-offline -q

COPY src ./src
RUN mvn clean package -DskipTests -q

# ── Etapa 2: imagen de producción (solo JRE) ─────────────────────────
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Crear carpeta de logs y usuario no root
RUN addgroup -S spring && adduser -S spring -G spring \
    && mkdir -p /app/logs \
    && chown -R spring:spring /app

USER spring

# Copiar únicamente el JAR compilado desde la etapa builder
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
