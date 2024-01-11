#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /sample_rails/tmp/pids/server.pid

# コンテナにdb tableを作成
rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production

# Then exec the container's main process (what's set as CMD in the Dockerfile).
# CMD ["rails", "server", "-b", "0.0.0.0"]が実行
exec "$@"
