@echo off
rem Runs the r2_jazzy container with GUI and network support.
rem Usage: run_r2_jazzy.bat [ROS_DOMAIN_ID]
rem   ROS_DOMAIN_ID - optional ROS domain ID (default: 0)

if "%1"=="" (
    set DOMAIN_ID=0
) else (
    set DOMAIN_ID=%1
)

docker run -it --rm ^
    --name r2_jazzy ^
    --network host ^
    -e DISPLAY=host.docker.internal:0 ^
    -e ROS_DOMAIN_ID=%DOMAIN_ID% ^
    -e ROS_LOCALHOST_ONLY=0 ^
    r2_jazzy
