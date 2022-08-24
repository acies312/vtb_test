#!/bin/sh
set -e

service rsyslog start
service haproxy start
service keepalived start

exec "$@"