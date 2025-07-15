# Script optimizado para desarrollo local - Recursos Humanos (Windows)
Write-Host "🚀 Iniciando entorno de desarrollo local (optimizado)..." -ForegroundColor Green

# Verificar si Docker está corriendo
try {
    docker info | Out-Null
} catch {
    Write-Host "❌ Docker no está corriendo. Por favor inicia Docker Desktop." -ForegroundColor Red
    exit 1
}

# Parar contenedores existentes si están corriendo
Write-Host "🛑 Deteniendo contenedores existentes..." -ForegroundColor Yellow
docker-compose down 2>$null

# Crear red si no existe
docker network create rrhh_network 2>$null

# Solo construir si es necesario
Write-Host "📦 Verificando imágenes..." -ForegroundColor Yellow
$backendExists = docker images -q rrhh_backend 2>$null
$frontendExists = docker images -q rrhh_frontend 2>$null

if (-not $backendExists -or -not $frontendExists) {
    Write-Host "� Construyendo imágenes necesarias..." -ForegroundColor Yellow
    docker-compose build
} else {
    Write-Host "✅ Imágenes ya existen, omitiendo construcción" -ForegroundColor Green
}

# Iniciar solo PostgreSQL primero
Write-Host "🐘 Iniciando PostgreSQL..." -ForegroundColor Yellow
docker-compose up -d postgres

# Esperar menos tiempo
Write-Host "⏳ Esperando PostgreSQL (10s)..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Iniciar backend
Write-Host "🔧 Iniciando backend..." -ForegroundColor Yellow
docker-compose up -d backend

# Esperar menos tiempo
Write-Host "⏳ Esperando backend (10s)..." -ForegroundColor Yellow
Start-Sleep -Seconds 10

# Iniciar frontend
Write-Host "🔧 Iniciando frontend..." -ForegroundColor Yellow
docker-compose up -d frontend

Write-Host ""
Write-Host "✅ Entorno de desarrollo iniciado!" -ForegroundColor Green
Write-Host ""
Write-Host "📍 URLs disponibles:" -ForegroundColor Cyan
Write-Host "   Frontend: http://localhost:3000" -ForegroundColor White
Write-Host "   Backend:  http://localhost:8000" -ForegroundColor White
Write-Host "   Base de datos: localhost:5433" -ForegroundColor White
Write-Host ""
Write-Host "🔧 Comandos útiles:" -ForegroundColor Cyan
Write-Host "   Ver logs:           docker-compose logs -f" -ForegroundColor White
Write-Host "   Parar servicios:    docker-compose down" -ForegroundColor White
Write-Host "   Reiniciar:          docker-compose restart" -ForegroundColor White
Write-Host ""
Write-Host "📊 Ver estado:" -ForegroundColor Cyan
Write-Host "   docker-compose ps" -ForegroundColor White
