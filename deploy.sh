#!/bin/bash
set -euo pipefail

IMAGE="potatorocket/gutendex"
HOST="elitedesk-2"
STACK_DIR="/opt/compose/gutendex"

echo "Building image..."
docker build -t "$IMAGE:latest" "$(dirname "$0")"

echo "Pushing to Docker Hub..."
docker push "$IMAGE:latest"

echo "Deploying on $HOST..."
ssh "$HOST" "cd $STACK_DIR && sudo docker compose pull gutendex && sudo docker compose up -d --force-recreate gutendex"

echo "Done."
