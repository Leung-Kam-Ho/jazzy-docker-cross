#!/bin/bash
cd "$(dirname "$0")/.."

echo "=========================================="
echo "ROS 2 Zenoh Bridge Speed Test (Mac Docker)"
echo "=========================================="

echo "Starting Docker Environment..."
docker-compose up -d --build

echo "Waiting for Zenoh Bridge to connect..."
sleep 5

echo "Starting high-frequency payload publisher (1MB messages @ 50Hz)..."
echo "We will use the quality_of_service_demo_cpp package to push data fast."

docker exec -it ros2_jazzy_node bash -c "source /opt/ros/jazzy/setup.bash && export RMW_IMPLEMENTATION=rmw_fastrtps_cpp && ros2 run quality_of_service_demo_cpp qos_talker --publish-count 500 --message-size 1048576"

echo "Done sending."
