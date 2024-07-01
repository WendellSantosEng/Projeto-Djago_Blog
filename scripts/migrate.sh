#!/bin/sh
python /djangoapp/manage.py makemigrations --noinput
python /djangoapp/manage.py migrate --noinput