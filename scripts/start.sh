#!/usr/bin/env bash
set -euo pipefail

PGDATA="${PGDATA:?PGDATA not set}"
PGPORT="${PGPORT:?PGPORT not set}"
PGHOST="${PGHOST:?PGHOST not set}"

echo "==> Starting local Postgres"
echo "    PGDATA: $PGDATA"
echo "    PORT:   $PGPORT"
echo "    SOCKET: $PGHOST"

# initialize pgdata if it doesn't exist
if [ ! -f "$PGDATA/PG_VERSION" ]; then
  echo "==> Initializing new Postgres cluster"
  initdb -D "$PGDATA"
fi

# skip if already running
if pg_ctl -D "$PGDATA" status > /dev/null 2>&1; then
  echo "==> Postgres already running"
  exit 0
fi

# ensure socket dir exists
mkdir -p "$PGHOST"

# start
pg_ctl -D "$PGDATA" \
  -o "-p $PGPORT -k $PGHOST" \
  -l pg.log \
  start

# wait until ready
echo "==> Waiting for Postgres to accept connections"
for i in {1..10}; do
  if pg_isready -p "$PGPORT" -h "$PGHOST" > /dev/null 2>&1; then
    echo "==> Postgres is ready"
    exit 0
  fi
  sleep 0.5
done

echo "ERROR: Postgres did not start in time"
exit 1
