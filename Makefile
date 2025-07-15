# Makefile para desarrollo local - Recursos Humanos

.PHONY: help build up down restart logs clean backend-shell frontend-shell db-shell migrate seed

help: ## Mostrar ayuda
	@echo "Comandos disponibles:"
	@echo "  build     - Construir todos los contenedores"
	@echo "  up        - Levantar todos los servicios"
	@echo "  down      - Parar todos los servicios"
	@echo "  restart   - Reiniciar todos los servicios"
	@echo "  logs      - Ver logs de todos los servicios"
	@echo "  clean     - Limpiar contenedores y volúmenes"
	@echo "  backend-shell  - Acceder al contenedor del backend"
	@echo "  frontend-shell - Acceder al contenedor del frontend"
	@echo "  db-shell  - Acceder a PostgreSQL"
	@echo "  migrate   - Ejecutar migraciones"
	@echo "  seed      - Ejecutar seeders"

build: ## Construir todos los contenedores
	docker-compose build

up: ## Levantar todos los servicios
	docker-compose up -d

down: ## Parar todos los servicios
	docker-compose down

restart: ## Reiniciar todos los servicios
	docker-compose restart

logs: ## Ver logs de todos los servicios
	docker-compose logs -f

clean: ## Limpiar contenedores y volúmenes
	docker-compose down -v
	docker system prune -f

backend-shell: ## Acceder al contenedor del backend
	docker-compose exec backend bash

frontend-shell: ## Acceder al contenedor del frontend
	docker-compose exec frontend sh

db-shell: ## Acceder a PostgreSQL
	docker-compose exec postgres psql -U recursos_humanos -d backend

migrate: ## Ejecutar migraciones
	docker-compose exec backend php artisan migrate

seed: ## Ejecutar seeders
	docker-compose exec backend php artisan db:seed

dev: ## Iniciar entorno de desarrollo completo
	@echo "🚀 Iniciando entorno de desarrollo..."
	make build
	make up
	@echo "✅ Entorno listo en:"
	@echo "   Frontend: http://localhost:3000"
	@echo "   Backend:  http://localhost:8000"
