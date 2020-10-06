#!/bin/sh

rm -f bootstrap/cache/*.php

./artisan migrate

./artisan config:clear

./artisan config:cache

./artisan route:cache

php-fpm
