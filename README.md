# jazzy-docker-cross

## Goal
A complete solution for ROS 2 (Jazzy) communication across **macOS**, **Windows**, and **Linux** — whether running **natively** or in **Docker containers** — fully offline over LAN.

## Constraints & Preferences
- **Linux** `--network host` works as expected — the container shares the host's network stack directly. DDS discovery (UDP multicast) just works.
- **macOS / Windows** Docker Desktop (since v4.34) supports `--network host` as an **opt-in** feature (Settings → Resources → Network → Enable host networking). However, it is **not true host networking** — it works at layer 4 (TCP/UDP) only, and the container cannot bind to specific host IPs or access raw sockets. DDS uses UDP multicast (layer 4), so it may work, but discovery traffic still routes through Docker's VM rather than the physical NIC directly. Without this feature enabled, containers get private VM-internal IPs that are not reachable from the LAN.
- Must work fully offline — no cloud services
- Fast DDS is the DDS implementation in ROS 2 Jazzy
- macOS on arm64 (Apple Silicon), ROS Docker image is amd64 — runs under Rosetta emulation

## Approach
`--network host` is used so DDS discovery happens on the host network interface, avoiding Docker bridge networking complications. On Linux this is straightforward; on macOS/Windows the Docker Desktop host networking feature must be enabled first.

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
- **Docker (macOS/Windows) ↔ native ROS 2 over LAN** — not yet completed. Even with Docker Desktop host networking enabled, it's unclear whether DDS multicast discovery reliably reaches the LAN. A discovery server, port publishing with `ROS_IP`, or VPN (WireGuard/tailscale) may still be needed for cross-machine communication.
