#!/usr/bin/env bash
set -euo pipefail

PGPORT="${PGPORT:?PGPORT not set}"
PGHOST="${PGHOST:?PGHOST not set}"
PGUSER="${PGUSER:?PGUSER not set}"
PGDATABASE="${PGDATABASE:?PGDATABASE not set}"

echo "==> Connecting to Postgres"
echo "  Host/Socket:    $PGHOST"
echo "  Port:           $PGPORT"
echo "  Database:       $PGDATABASE"
echo "  User:           $PGUSER"

psql -h "$PGHOST" -p "$PGPORT" -U "$PGUSER" -d "$PGDATABASE" "$@"
