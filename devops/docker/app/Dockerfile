FROM php:7.4-fpm-alpine

WORKDIR /code

EXPOSE 9000

COPY devops/docker/app/command-prod.sh /opt/command-prod.sh

RUN docker-php-ext-install pdo pdo_mysql opcache

# All things composer
RUN php -r 'readfile("https://getcomposer.org/installer");' > composer-setup.php \
	&& php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
	&& rm -f composer-setup.php \
	&& chown www-data.www-data /var/www

composer install

FROM php:7.4-fpm-alpine

