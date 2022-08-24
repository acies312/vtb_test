#!/bin/sh
set -e

echo "<h1>Hello, World! $HOSTNAME</h1>" > /usr/share/nginx/html/index.html
nginx -g 'daemon off;'

exec "$@"