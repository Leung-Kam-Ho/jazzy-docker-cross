#!/bin/bash
cd "$(dirname "$0")/.."

echo "=========================================="
echo "ROS 2 Zenoh Bridge Speed Test (Mac Docker)"
echo "=========================================="

echo "Starting Docker Environment..."
docker-compose up -d --build

echo "Waiting for Zenoh Bridge to connect..."
sleep 5

echo "Stopping any existing talker..."
docker exec ros2_jazzy_node pkill -f blob_talker.py 2>/dev/null || true

echo "Starting EXTREME LIDAR Test (5MB @ 30Hz = 150MB/s Target)..."
echo "This targets 150MB/s, which will test the absolute limit of Gigabit Ethernet."

docker exec -it ros2_jazzy_node bash -c "source /opt/ros/jazzy/setup.bash && export RMW_IMPLEMENTATION=rmw_fastrtps_cpp && python3 /root/workspace/tests/blob_talker.py 5242880 30"

echo "Done sending."
