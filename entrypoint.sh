#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /backend/tmp/pids/server.pid

# データベースが起動するまで待機する
# 開発環境
# until mysqladmin ping -h "db" -u "root" --password="$DB_PASSWORD" &> /dev/null; do
# 本番環境
until mysqladmin ping -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" &> /dev/null; do
  echo "Waiting for database to become available..."
  sleep 2
done
echo "Database is up!"

# # データベースを初期化(準備用)
# export DISABLE_DATABASE_ENVIRONMENT_CHECK=1
# rails db:drop

# tableを作成
# 開発環境
# if ! mysql -h "db" -u "root" --password="$DB_PASSWORD" -e 'use fable_backend_development'; then
# 本番環境
if ! mysql -h "$DB_HOST" -u "$DB_USERNAME" --password="$DB_PASSWORD" -e "use $DB_DATABASE;" ; then
  echo "Creating database..."
  rails db:create
fi

rails db:migrate

# データベースが空の場合、seedを実行
if ! rails runner "exit User.exists? ? 0 : 1"; then
  echo "Seeding database..."
  rails db:seed
fi

rails db:rollback STEP=4
rails db:migrate
rails db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# CMD ["rails", "server", "-b", "0.0.0.0"]が実行
exec "$@"
