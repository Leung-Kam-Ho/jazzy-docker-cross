#!/bin/bash
# Starts a Fast DDS discovery server for cross-device ROS 2 communication.
# Usage: ./run_r2_jazzy_discovery_server.sh
# Run this on one machine first, then connect containers from any device.

docker run -it --rm \
    --name r2_jazzy_discovery_server \
    -p 11811:11811/udp \
    r2_jazzy \
    fastdds discovery -i 0 -l 0.0.0.0 -p 11811
