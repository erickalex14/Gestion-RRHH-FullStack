FROM node:18-alpine

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de package primero (para cache)
COPY package*.json ./

# Instalar dependencias
RUN npm ci

# Copiar el resto del código
COPY . .

# Exponer puerto
EXPOSE 3000

# Variables de entorno
ENV NODE_ENV=development

# Comando por defecto
CMD ["npm", "run", "dev"]
