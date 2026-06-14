# jazzy-docker-cross

## Goal
A complete solution for ROS 2 (Jazzy) communication across **macOS**, **Windows**, and **Linux** — whether running **natively** or in **Docker containers** — fully offline over LAN.

## Constraints & Preferences
- Docker Desktop for Mac runs containers inside a hidden Linux VM using HyperKit. Containers get private bridge IPs (e.g. 172.17.0.x) that exist only inside the VM — they are **not directly reachable from the LAN**. A Linux machine on the same network cannot send DDS discovery packets to a Docker container on macOS without extra configuration. `--network host` on macOS does not truly share the host network stack; containers are still isolated in the VM. However, it allows the container to bind to host ports and use `host.docker.internal` to reach the macOS host, which enables workarounds like discovery servers or port publishing with `ROS_IP`/`ROS_LOCALHOST_ONLY`.
- Must work fully offline — no cloud services
- Fast DDS is the DDS implementation in ROS 2 Jazzy
- macOS on arm64 (Apple Silicon), ROS Docker image is amd64 — runs under Rosetta emulation

## Approach
`--network host` is used so DDS discovery happens directly on the host network interface, avoiding Docker bridge networking complications.

## Usage

### Build the image
```bash
docker build -t r2_jazzy .
```

### Run the container
```bash
./run_r2_jazzy.sh <container_name> <ros_domain_id>
./run_r2_jazzy.bat <container_name> <ros_domain_id>
```

Examples:
```bash
./run_r2_jazzy.sh c1 0      # container "c1", domain 0
./run_r2_jazzy.sh           # defaults: name=r2_jazzy, domain=0
```

X11 forwarding is enabled for GUI tools (rviz2, rqt, etc.). On macOS, install [XQuartz](https://www.xquartz.org/) first; on Windows, use VcXsrv or similar.

## TODO
- **macOS Docker ↔ native ROS 2 over LAN** — not yet completed. `--network host` on Docker Desktop for Mac does not expose container DDS directly to the LAN. A discovery server, port publishing with `ROS_IP`, or VPN (WireGuard/tailscale) is still needed for cross-machine communication.
