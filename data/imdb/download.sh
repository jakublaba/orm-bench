#!/usr/bin/env bash
set -euo pipefail

BASE_URL="https://datasets.imdbws.com"

FILES=(
    "name.basics.tsv.gz"
    "title.akas.tsv.gz"
    "title.basics.tsv.gz"
    "title.crew.tsv.gz"
    "title.episode.tsv.gz"
    "title.principals.tsv.gz"
    "title.ratings.tsv.gz"
)

# ensure files get downloaded to this script's directory
mkdir -p . && cd "$(dirname "$0")"

echo "==> Downloading IMDb datasets to $(pwd)"

for f in "${FILES[@]}"; do
    if [ -f "$f" ]; then
        echo "Skipping $f (already exists)"
    else
        echo "Downloading $f ..."
        curl -L -O "$BASE_URL/$f"
    fi
done

echo "==> All downloads complete"
