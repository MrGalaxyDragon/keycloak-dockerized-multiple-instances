#!/bin/bash

set -o allexport
source .env
set +o allexport

if [[ -z "$KEYCLOAK_CONTAINER_NAME" || -z "$REALM_NAME" ]]; then
  echo "❌ ERROR: .env must define 'KEYCLOAK_CONTAINER_NAME', and 'REALM_NAME'"
  exit 1
fi

EXPORT_PATH="/opt/keycloak/data/export"

LOCAL_EXPORT_DIR="${EXPORT_DIR_NAME}/${KEYCLOAK_CONTAINER_NAME}"
mkdir -p "$LOCAL_EXPORT_DIR"

echo "📦 Exporting realm '$REALM_NAME' with users from container '$KEYCLOAK_CONTAINER_NAME'..."

docker exec -u 0 "$KEYCLOAK_CONTAINER_NAME" bash -c "\"/opt/keycloak/bin/kc.sh\" export --dir='$EXPORT_PATH' --realm='$REALM_NAME' --users='$USERS_EXPORT_STRATEGY'"

docker cp "$KEYCLOAK_CONTAINER_NAME:$EXPORT_PATH/." "$LOCAL_EXPORT_DIR"

echo "✅ Export complete. Files saved to: $LOCAL_EXPORT_DIR"