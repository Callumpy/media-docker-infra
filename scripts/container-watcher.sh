#!/bin/bash

# List of other containers
other_containers=("plex" "sonarr" "radarr" "sabnzbd" "prowlarr" "overseerr" "tautulli" "notifiarr")

# Check if rclone container is running
if docker ps -f name=rclone --format '{{.Names}}' | grep -q "rclone"; then
    echo "rclone container is running."

    # Check rclone container health
    if docker inspect --format '{{.State.Health.Status}}' rclone | grep -q "healthy"; then
        echo "rclone container is healthy."

        for container in "${other_containers[@]}"; do
            # Check if other container is not running
            if ! docker ps -f name="$container" --format '{{.Names}}' | grep -q "$container"; then
                echo "$container is not running. Starting..."
                docker start "$container"
            else
                echo "$container is already running."
            fi
        done

    else
        echo "rclone container is not healthy."

        for container in "${other_containers[@]}"; do
            # Check if other container is running and stop it
            if docker ps -f name="$container" --format '{{.Names}}' | grep -q "$container"; then
                echo "$container is running. Stopping..."
                docker stop "$container"
            else
                echo "$container is not running."
            fi
        done
    fi

else
    echo "rclone container is not running."

    for container in "${other_containers[@]}"; do
        # Check if other container is running and stop it
        if docker ps -f name="$container" --format '{{.Names}}' | grep -q "$container"; then
            echo "$container is running. Stopping..."
            docker stop "$container"
        else
            echo "$container is not running."
        fi
    done
fi