#!/bin/sh

echo "Waiting for PostgreSQL to be ready..."
until nc -z -v -w30 postgres 5432; do
  echo "Waiting for PostgreSQL database connection..."
  sleep 1
done

if [ ! -f /usr/src/app/initialized ]; then
  npm run migrate-dev
  npm run generate

  touch /usr/src/app/initialized
fi

npm run start:dev
