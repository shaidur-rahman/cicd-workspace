#!/bin/bash

# ANSI escape codes for colors
CYAN="\e[1;36m"
RED="\033[38;2;255;0;0m"
RESET="\e[0m"

# USage:  Desktop/cicd-workspace/build-projects.sh thyme-metavalidate metafour-orm netcourier-parent metafour-cloud  netcourier-models netcourier-ng netcws-client netcws-client-mf netcws-client-ng netcws-client-cloud netcourier-api netcourier-jobimport netcourier-recon netcourier-integration netcourier-booking netcourier-shopping-cart netcourier-data

# Function to display help message
show_help() {
    echo "Usage: $0 REPO_NAME_1 REPO_NAME_2 ..."
    echo "Opens terminal tabs for each specified repository under /media/shaidur/SSD2/git/."
    echo "Example: $0 thyme-metavalidate metafour-orm netcourier-parent metafour-cloud  netcourier-models netcourier-ng netcws-client netcws-client-mf netcws-client-ng netcws-client-cloud netcourier-api netcourier-jobimport netcourier-recon netcourier-integration netcourier-booking netcourier-shopping-cart netcourier-data"
    exit 1
}

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    show_help
fi

# Base directory
BASE_DIR="/media/shaidur/SSD2/git"

# Loop through each argument (repository name)
for repo in "$@"; do
    # Check if the directory exists
    if [ ! -d "$BASE_DIR/$repo" ]; then
        echo ""
        echo -e "${RED}Directory $BASE_DIR/$repo does not exist. Aborting the process...${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        break
    else
		cd "$BASE_DIR/$repo"
    fi

	echo $"Building $repo"
    if ! mvn clean install; then
        echo ""
        echo -e "${RED}Build failed for $repo. Abborting the process...${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        break
	fi
	
    echo "-------------------------------------------"
    echo ""
done

