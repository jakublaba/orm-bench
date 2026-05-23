#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DB_NAME="${PGDATABASE:?PGDATABASE not set}"
PGPORT="${PGPORT:?PGPORT not set}"
PGDATA="${PGDATA:?PGDATA not set}"
PGHOST="${PGHOST:?PGHOST not set}"

echo "==> Resetting database: $DB_NAME"
echo "    PGDATA: $PGDATA"
echo "    PGHOST: $PGHOST"
echo "    PGPORT: $PGPORT"

# restart 
"$SCRIPT_DIR/stop.sh"
"$SCRIPT_DIR/start.sh"

# re-create db
echo "==> Recreating database"
dropdb --if-exists "$DB_NAME"
createdb "$DB_NAME"

# apply schema
echo "==> Applying schema"
psql "$DB_NAME" -f "$SCRIPT_DIR/../postgres/schema.sql"

# load data
psql "$DB_NAME" -f "$SCRIPT_DIR/../postgres/load.sql"
