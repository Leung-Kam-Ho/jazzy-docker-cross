@echo off
rem Runs the r2_jazzy container with GUI and network support.
rem Usage: run_r2_jazzy.bat <container_name> [ROS_DOMAIN_ID] [DISCOVERY_SERVER_IP]
rem   container_name     - name for the container (default: r2_jazzy)
rem   ROS_DOMAIN_ID      - optional ROS domain ID (default: 0)
rem   DISCOVERY_SERVER_IP - optional Fast DDS discovery server IP for cross-device comm

if "%1"=="" (
    set NAME=r2_jazzy
) else (
    set NAME=%1
)

if "%2"=="" (
    set DOMAIN_ID=0
) else (
    set DOMAIN_ID=%2
)

if "%3"=="" (
    set DISCOVERY_ARGS=-e ROS_AUTOMATIC_DISCOVERY_RANGE=SUBNET
) else (
    set DISCOVERY_ARGS=-e ROS_DISCOVERY_SERVER=%3:11811
)

docker run -it --rm ^
    --name %NAME% ^
    --network r2_jazzy_net ^
    -e DISPLAY=host.docker.internal:0 ^
    -e ROS_DOMAIN_ID=%DOMAIN_ID% ^
    %DISCOVERY_ARGS% ^
    -e FASTDDS_BUILTIN_TRANSPORTS=UDPv4 ^
    r2_jazzy
