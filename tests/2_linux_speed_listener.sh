#!/bin/bash
cd "$(dirname "$0")/.."

echo "=========================================="
echo "ROS 2 Zenoh Bridge Speed Test (Linux Host)"
echo "=========================================="

echo "Starting listener to receive high-frequency payload..."

export RMW_IMPLEMENTATION=rmw_fastrtps_cpp
ros2 run quality_of_service_demo_cpp qos_listener

echo "Listener stopped."
