#!/bin/bash
# Runs the r2_jazzy container with GUI and network support.
# Usage: ./run_r2_jazzy.sh [ROS_DOMAIN_ID]
#   ROS_DOMAIN_ID - optional ROS domain ID (default: 0)

DOMAIN_ID=${1:-0}

docker run -it --rm \
    --name r2_jazzy \
    --network host \
    -e DISPLAY=host.docker.internal:0 \
    -e ROS_DOMAIN_ID="$DOMAIN_ID" \
    -e ROS_LOCALHOST_ONLY=0 \
    r2_jazzy
