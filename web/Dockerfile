FROM php:7.3.3-apache

RUN apt-get update

RUN apt-get install -y nano

COPY files/ /var/www/html/

RUN docker-php-ext-install mysqli

EXPOSE 80 1234
