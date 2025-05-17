#!/bin/bash

set -o allexport
source .env
set +o allexport

for var in "${!PORT_@}"; do
  num=${var#PORT_}
  project="${PROJECT_ROOT_NAME}-${num}"

  echo "Stopping and removing project '$project'..."

  docker compose -p "$project" -f "$COMPOSE_FILE" down -v
done