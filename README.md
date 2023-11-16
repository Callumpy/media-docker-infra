# media-docker-infra

This repo contains a backup of the Docker compose files that I use to spin up my homeserver so that others can make use of them or use them for inspiration.

## Media
- **Plex** (serves content)
	- **Sonarr** (grabs TV)
	- **Radarr** (grabs Movies)
	- **Prowlarr** (makes API requests to NZB sites and serves to Sonarr and Radarr)
	- **SabNZBd** (downloader)
	- **Tautulli** (monitors plex usage)
	- **Overseerr** (plex requests)
	- **Notifiarr** (notify on changes from above apps)
- **Rclone** (makes a copy of my files in GDrive and deletes local - also mounts GDrive for file streaming)
- **Discord MusicBot**

## Server
- **Netdata** (monitors the server)
- **NGINX Proxy Manager** (proxies HTTPS traffic to local docker IPs)
- **Watchtower** (auto updates docker containers from DockerHub)

## Home
- **HomeAssistant** (fully fledged home automation suite)
- **PiHole** (internal DNS with unbound)
- **Mosquitto** (used for some devices to send data to HASS + TeslaMate)

## Tesla
- **TeslaMate** (grabs data from tesla API)
- **Postgres** (storing the data from TeslaMate)
- **Grafana** (graph and display the TeslaMate data)
- **TeslaMate ABRP** (sends live car data to A Better Route Planner)
- **TeslaMate Agile** (updates TeslaMate charging data with Octopus Agile prices for realistic cost tracking)
