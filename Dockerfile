FROM php:8.1-fpm

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y libzip-dev libpng-dev libjpeg-dev libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd zip pdo pdo_mysql

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar el archivo composer.json y composer.lock
COPY composer.json composer.lock ./

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instalar las dependencias de PHP
RUN composer install

# Copiar el resto de la aplicación
COPY . .

# Exponer el puerto 9000
EXPOSE 9000

# Iniciar PHP-FPM
CMD ["php-fpm"]
