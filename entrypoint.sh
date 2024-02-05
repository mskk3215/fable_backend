#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /backend/tmp/pids/server.pid

# データベースが起動するまで待機する
# until mysqladmin ping -h "db" -u "root" --password="$DB_PASSWORD" &> /dev/null; do
until mysqladmin ping -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" &> /dev/null; do
  echo "Waiting for database to become available..."
  sleep 2
done
echo "Database is up!"

# tableを作成
# if ! mysql -h "db" -u "root" --password="$DB_PASSWORD" -e 'use fable_backend_development'; then
if ! mysql -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" -e "use $DB_DATABASE;" ; then

  echo "Creating database..."
  rails db:create
fi

rails db:migrate

# if ! rails runner 'User.exists?' ; then
#   echo "Seeding database..."
#   rails db:seed
# fi
if ! rails runner "exit User.exists? ? 0 : 1"; then
  echo "Seeding database..."
  rails db:seed
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# CMD ["rails", "server", "-b", "0.0.0.0"]が実行
exec "$@"
