FROM php:8.2-fpm-alpine

# Instalar dependencias del sistema
RUN apk add --no-cache \
    git \
    curl \
    libpng-dev \
    oniguruma-dev \
    libxml2-dev \
    zip \
    unzip \
    postgresql-dev

# Instalar extensiones PHP
RUN docker-php-ext-install pdo_pgsql mbstring exif pcntl bcmath gd

# Obtener Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos de composer primero (para cache)
COPY composer.json composer.lock ./

# Instalar dependencias de PHP
RUN composer install --no-scripts --no-autoloader

# Copiar el resto del código (sin .env)
COPY . .

# NO crear archivo .env - usar solo variables de entorno
# RUN cp .env.example .env

# Generar autoloader
RUN composer dump-autoload --optimize

# Crear archivo .env vacío para que Laravel no falle, pero las variables de entorno tendrán prioridad
RUN touch .env

# Generar clave si no existe
RUN php artisan key:generate 2>/dev/null || true

# Crear directorios necesarios
RUN mkdir -p storage/logs storage/framework/cache storage/framework/sessions storage/framework/views bootstrap/cache

# Permisos
RUN chmod -R 775 storage bootstrap/cache

# Exponer puerto
EXPOSE 8000

# Comando por defecto
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8000"]
