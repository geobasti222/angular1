# Usar una imagen base de Node.js para construir la aplicación
FROM node:16 as build

# Establecer el directorio de trabajo
WORKDIR /app

# Copiar el archivo package.json y package-lock.json
COPY package*.json ./

# Instalar las dependencias
RUN npm install

# Copiar todo el código fuente del proyecto
COPY . .

# Construir la aplicación Angular
RUN npm run build --prod

# Usar una imagen base de Nginx para servir la aplicación
FROM nginx:alpine

# Copiar los archivos compilados desde la fase de construcción
COPY --from=build /app/dist/angular1 /usr/share/nginx/html

# Exponer el puerto en el que Nginx estará escuchando
EXPOSE 8060

# Comando por defecto para ejecutar Nginx
CMD ["nginx", "-g", "daemon off;"]
