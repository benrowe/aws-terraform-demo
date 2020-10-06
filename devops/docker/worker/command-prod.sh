#!/bin/sh

rm -f bootstrap/cache/*.php

./artisan config:cache

./artisan queue:work
