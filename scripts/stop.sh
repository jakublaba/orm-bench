#!/usr/bin/env bash
set -euo pipefail

PGDATA="${PGDATA:?PGDATA not set}"

if pg_ctl -D "$PGDATA" status > /dev/null 2>&1; then
  echo "==> Stopping Postgres"
  pg_ctl -D "$PGDATA" stop -m fast
else
  echo "==> Postgres is not running"
fi
