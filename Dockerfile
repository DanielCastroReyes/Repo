FROM php:8.0.0-apache
ARG DEBIAN_FRONTEND=noninteractive

RUN docker-php-ext-install mysqli

RUN apt update && apt install -y libzip-dev zlib1g-dev cmatrix && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install zip
RUN a2enmod rewrite

# Cambiar puerto Apache a 81
RUN sed -i 's/Listen 80/Listen 81/g' /etc/apache2/ports.conf
RUN sed -i 's/<VirtualHost \*:80>/<VirtualHost *:81>/g' /etc/apache2/sites-available/000-default.conf

EXPOSE 81
