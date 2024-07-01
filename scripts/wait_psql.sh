#!/bin/bash

while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "Waiting for postgres database to be ready ($POSTGRES_HOST $POSTGRES_PORT) ... "
  sleep 2
done

echo "Postgres is ready! ($POSTGRES_HOST:$POSTGRES_PORT)"

echo "Listing files in /djangoapp:"
ls /djangoapp