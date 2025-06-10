#!/bin/bash

# --- Configuration ---
# Set the name of the Docker image for OpenROAD Flow Scripts
# You can find the latest image tag on https://hub.docker.com/r/openroad/flow-scripts/tags
# ORFS_IMAGE="openroad/orfs:latest"
ORFS_IMAGE="orfs-custom:latest"
# Set the path to your local directory where you want to save your design files.
# The script will create this directory if it doesn't exist.
DESIGNS_DIR="${HOME}/eda/orfs_designs"
TERMINAL="xterm -e"
# TERMINAL="gnome-terminal -e"
# --- Script Logic ---

# Create the designs directory if it doesn't exist
mkdir -p "${DESIGNS_DIR}"

# Check if X server is available
if [ -z "$DISPLAY" ]; then
	echo "ERROR: The DISPLAY environment variable is not set."
	echo "Please ensure you are running this script from a graphical session."
	exit 1
fi

# Give Docker container access to your X server
xhost +local:docker

# Run the OpenROAD Flow Scripts Docker container
# docker run -it --rm \
# 	-v "${DESIGNS_DIR}:/designs" \
# 	-v /tmp/.X11-unix:/tmp/.X11-unix \
# 	-e DISPLAY=$DISPLAY \
# 	--user $(id -u):$(id -g) \
# 	"${ORFS_IMAGE}"

${TERMINAL} docker run -it --rm \
	-v "${DESIGNS_DIR}:/designs" \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-e DISPLAY=$DISPLAY \
	-w "/designs" \
	--user $(id -u):$(id -g) \
	"${ORFS_IMAGE}"

sleep 1
