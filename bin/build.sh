#!/usr/bin/env bash

set -ex

DIR=$(pwd)
TMP=$DIR/tmp

mkdir -p $TMP
unzip -d $TMP/rwanda_village -o "$DIR/data/Rwanda Villages.zip"

ogr2ogr -f GeoJSONSeq /dev/stdout "$TMP/rwanda_village/Village.shp"  \
| node $DIR/src/filter.js \
| tippecanoe -o $TMP/rw_villages.mbtiles --no-tile-compression --maximum-zoom=14 --minimum-zoom=8 --base-zoom=14 --simplification=2 --hilbert --no-feature-limit --no-tile-size-limit --force

mkdir -p $DIR/docs
tile-join \
    --force \
    --no-tile-compression \
    -n "rwanda-village-polygons-tiles" \
    -N "Rwanda Village Polygons by WorldBank for Open Reverse Geocoder" \
    -A "©WorldBank" \
    --output-to-directory=$DIR/docs/tiles \
    --no-tile-size-limit $DIR/tmp/rw_villages.mbtiles
