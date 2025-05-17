#!/bin/bash

set -o allexport
source .env
set +o allexport

for var in "${!PORT_@}"; do
  num=${var#PORT_}
  port=${!var}
  project="${PROJECT_ROOT_NAME}-${num}"

  echo "Starting instance '$project' on port $port..."

  KEYCLOAK_PORT=$port \
  docker compose -p "$project" -f "$COMPOSE_FILE" up -d
done