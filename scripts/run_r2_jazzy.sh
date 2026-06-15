#!/bin/bash
set -euo pipefail

NAME=${1:-r2_jazzy}
DOMAIN_ID=${2:-0}
DISPLAY_VAL="${DISPLAY:-host.docker.internal:0}"

docker run -it --rm \
    --name "$NAME" \
    --network host \
    -e DISPLAY="$DISPLAY_VAL" \
    -e ROS_DOMAIN_ID="$DOMAIN_ID" \
    -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
    r2_jazzy
