#!/bin/bash
set -e

# サーバー起動時にデータベースを待つ
bundle exec rails db:prepare

exec "$@"
