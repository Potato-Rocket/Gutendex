#!/bin/sh
set -e

until python -c "
import psycopg2
psycopg2.connect(
    host='$DATABASE_HOST',
    port='$DATABASE_PORT',
    user='$DATABASE_USER',
    password='$DATABASE_PASSWORD',
    dbname='$DATABASE_NAME',
)
" 2>/dev/null; do
    echo "Waiting for postgres..."
    sleep 2
done

python manage.py migrate --noinput
python manage.py collectstatic --noinput

exec "$@"
