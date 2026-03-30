#!/bin/sh

set -eu

CONTAINER_NAME="${1:-wordpress-oceanwp}"
TARGET_DIR="${2:-plugins}"

mkdir -p "$TARGET_DIR"
docker cp "$CONTAINER_NAME:/var/www/html/wp-content/plugins/." "$TARGET_DIR"

