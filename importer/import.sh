#!/bin/sh
set -eu

MARKER_PATH="/var/lib/importer/import.done"
if [ -f "$MARKER_PATH" ]; then
  echo "Import already completed; skipping."
  exit 0
fi

mkdir -p "$(dirname "$MARKER_PATH")"
mkdir -p "$(dirname "$PBF_PATH")"
curl -fL -o "$PBF_PATH" "https://download.geofabrik.de/asia/japan-latest.osm.pbf"
osm2pgsql --slim "$PBF_PATH"
touch "$MARKER_PATH"
