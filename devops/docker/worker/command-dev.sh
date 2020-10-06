#!/bin/sh

composer install

./artisan queue:work
