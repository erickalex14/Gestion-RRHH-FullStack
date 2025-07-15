#!/bin/bash

# Script para desarrollo local - Recursos Humanos
echo "🚀 Iniciando entorno de desarrollo local..."

# Verificar si Docker está corriendo
if ! docker info > /dev/null 2>&1; then
    echo "❌ Docker no está corriendo. Por favor inicia Docker Desktop."
    exit 1
fi

# Crear red si no existe
docker network create rrhh_network 2>/dev/null || true

# Construir y levantar servicios
echo "📦 Construyendo contenedores..."
docker-compose build

echo "🔧 Iniciando servicios..."
docker-compose up -d postgres

echo "⏳ Esperando que PostgreSQL esté listo..."
sleep 10

echo "🔧 Iniciando backend..."
docker-compose up -d backend

echo "⏳ Esperando que el backend esté listo..."
sleep 15

echo "🔧 Iniciando frontend..."
docker-compose up -d frontend

echo ""
echo "✅ Entorno de desarrollo iniciado correctamente!"
echo ""
echo "📍 URLs disponibles:"
echo "   Frontend: http://localhost:3000"
echo "   Backend:  http://localhost:8000"
echo "   Base de datos: localhost:5433"
echo ""
echo "🔧 Comandos útiles:"
echo "   Ver logs:           docker-compose logs -f"
echo "   Parar servicios:    docker-compose down"
echo "   Reiniciar:          docker-compose restart"
echo "   Acceder al backend: docker-compose exec backend bash"
echo ""
