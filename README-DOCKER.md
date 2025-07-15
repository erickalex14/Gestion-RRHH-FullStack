# Recursos Humanos - Desarrollo Local con Docker

## 🚀 Estrategia de Desarrollo Local

Este proyecto implementa una estrategia de desarrollo local utilizando Docker con servicios aislados y comunicación entre contenedores para mantener consistencia y reproducibilidad.

### 📋 Arquitectura de Desarrollo Local

- **Backend Laravel**: Contenedor Docker con PHP 8.2, composer y dependencias
- **Frontend React**: Contenedor separado con Node.js 18 y Vite
- **Base de Datos PostgreSQL**: Contenedor con persistencia de datos
- **Comunicación aislada**: Red Docker interna entre servicios

## 🛠️ Prerequisitos

- Docker Desktop instalado y ejecutándose
- Docker Compose v2+
- Make (opcional, para comandos simplificados)

## 🚀 Inicio Rápido

### Opción 1: Script automatizado (Windows)
```powershell
.\dev-start.ps1
```

### Opción 2: Make (recomendado)
```bash
make dev
```

### Opción 3: Docker Compose manual
```bash
# Construir contenedores
docker-compose build

# Levantar servicios
docker-compose up -d
```

## 📍 URLs del Entorno

- **Frontend**: http://localhost:3000
- **Backend API**: http://localhost:8000
- **Base de datos**: localhost:5433

## 🔧 Comandos Útiles

### Gestión de servicios
```bash
make up          # Levantar servicios
make down        # Parar servicios  
make restart     # Reiniciar servicios
make logs        # Ver logs en tiempo real
```

### Desarrollo
```bash
make backend-shell   # Acceder al contenedor backend
make frontend-shell  # Acceder al contenedor frontend
make migrate        # Ejecutar migraciones
make seed           # Ejecutar seeders
```

### Limpieza
```bash
make clean      # Limpiar contenedores y volúmenes
```

## 📝 Configuración de Base de Datos

La configuración está sincronizada con tu archivo `.env`:

- **Host**: postgres (interno), localhost:5433 (externo)
- **Base de datos**: backend
- **Usuario**: recursos_humanos
- **Password**: 123456

## 🐛 Debugging

### Ver logs específicos
```bash
docker-compose logs backend
docker-compose logs frontend
docker-compose logs postgres
```

### Acceder a contenedores
```bash
# Backend Laravel
docker-compose exec backend bash

# Frontend React
docker-compose exec frontend sh

# Base de datos
docker-compose exec postgres psql -U recursos_humanos -d backend
```

### Comandos Laravel dentro del contenedor
```bash
# Dentro del contenedor backend
php artisan migrate:fresh --seed
php artisan cache:clear
php artisan config:clear
php artisan route:list
```

## 🔄 Flujo de Desarrollo

1. **Iniciar entorno**: `make dev`
2. **Desarrollar**: Los cambios se reflejan automáticamente
3. **Debugging**: Usar logs y shell access
4. **Parar entorno**: `make down`

## 📂 Estructura de Archivos Docker

```
├── docker-compose.yml          # Orquestación de servicios
├── recursos_humanos-backend/
│   ├── Dockerfile             # Imagen Laravel
│   └── .dockerignore          # Archivos excluidos
├── recursos-humanos-frontend/
│   ├── Dockerfile             # Imagen React
│   └── .dockerignore          # Archivos excluidos
├── dev-start.ps1              # Script Windows
├── dev-start.sh               # Script Linux/Mac
└── Makefile                   # Comandos make
```

## 🌐 Entorno Reproducible

- **Volúmenes persistentes**: Base de datos y node_modules
- **Variables de entorno**: Configuración consistente
- **Red aislada**: Comunicación segura entre contenedores
- **Hot reload**: Cambios automáticos en desarrollo
