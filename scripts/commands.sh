#!/bin/sh

set -e

while ! nc -z $POSTGRES_HOST $POSTGRES_PORT; do
  echo "Waiting for postgres database to be ready ($POSTGRES_HOST $POSTGRES_PORT) ... "
  sleep 2
done

echo "Postgres is ready! ($POSTGRES_HOST:$POSTGRES_PORT)"

echo "Listing files in /djangoapp:"
ls /djangoapp

python /djangoapp/manage.py collectstatic --noinput
python /djangoapp/manage.py makemigrations --noinput
python /djangoapp/manage.py migrate --noinput
python /djangoapp/manage.py runserver 0.0.0.0:8000

