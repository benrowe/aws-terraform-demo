FROM php:7.4-fpm-alpine

WORKDIR /code

#RUN pecl install redis-5.1.0
RUN apt-get update && \
    docker-php-ext-install pdo pdo_mysql opcache redis

COPY devops/docker/app/command-prod.sh /usr/local/bin/init.sh

# All things composer
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
	&& rm -f composer-setup.php \
	&& chown www-data.www-data /var/www

FROM php:7.4-fpm-alpine

#RUN pecl install redis-5.1.0
RUN apt-get update && \
    docker-php-ext-install pdo pdo_mysql opcache redis

WORKDIR /code/composer
COPY --from=0 /code /code

CMD /usr/local/bin/init.sh

