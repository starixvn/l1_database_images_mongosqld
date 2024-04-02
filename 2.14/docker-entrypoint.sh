#!/bin/bash
set -Eeuo pipefail

if [ "${1:0:1}" = '-' ]; then
    set -- mongosqld --config=/app/mongosqld.conf "$@"
fi

exec "$@"
