#!/usr/bin/env bash

set -e

role=${CONTAINER_ROLE:-worker}

echo "Starting $role"

if [ "$role" = "worker" ]; then
    echo "Running the worker"
    php artisan queue:work --verbose --tries=3 --timeout=90
elif [ "$role" = "scheduler" ]; then
    echo "Running the scheduler"
    while [ true ]
    do
      php artisan schedule:run --verbose --no-interaction &
      sleep 60
    done
fi


