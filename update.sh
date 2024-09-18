#!/bin/bash

# ANSI escape codes for colors
RED="\033[38;2;255;0;0m"
CYAN="\e[1;36m"
RESET="\e[0m"

# Check if the user requested help
if [[ $1 == "--help" ]]; then
    echo -e "These are common ${CYAN}update.sh${RESET} commands used in various situations:"
    echo ""

    echo -e "start a working area (default usage)"
    echo -e "   ${CYAN}update.sh${RESET}                   Checkout 'master' and rebase with 'upstream/master'"
    echo ""

    echo -e "update the working area"
    echo -e "   ${CYAN}update.sh push${RESET}             Checkout 'master', rebase with 'upstream/master', and push to 'origin master'"
    echo -e "   ${CYAN}update.sh <branch>${RESET}         Checkout the specified branch and rebase with 'upstream/master'"
    echo -e "   ${CYAN}update.sh <branch> push${RESET}    Checkout the specified branch, rebase with 'upstream/master', and push to 'origin <branch>'"
    echo ""

    echo -e "rebase with a different branch"
    echo -e "   ${CYAN}update.sh <branch> <up-branch>${RESET}        Checkout <branch> and rebase with 'upstream/<up-branch>'"
    echo -e "   ${CYAN}update.sh <branch> <up-branch> push${RESET}   Checkout <branch>, rebase with 'upstream/<up-branch>', and push to 'origin <branch>'"
    echo ""

    echo -e "For more information, see:"
    echo -e "   ${CYAN}update.sh --help${RESET}       Show this help message"
    exit 0
fi


# Main tasks starts from here ---------------------------------------------------
dirc=/home/shaidur/git
cd "$dirc"

projects=("netcourier-parent" "metafour-cloud" "metafour-auth" "netcourier-models" "netcourier-ng" "netcws-client" "netcws-client-mf" "netcws-client-ng" "netcws-client-cloud" "netcourier-api" "netcourier-jobimport" "netcourier-recon" "netcourier-integration" "netcourier-blend" "netcourier-booking" "netcourier-cloud" "netcourier-online" "netcourier-data" "netcourier-rs" "netcourier-exchange" "netcourier" "mafv2")

# Parse input parameters
local_branch="master"
upstream_branch="master"
push_flag=false

# Determine the branches and push flag based on input
if [[ -n $1 && $1 != "push" ]]; then
    local_branch="$1"
fi

if [[ -n $2 && $2 != "push" ]]; then
    upstream_branch="$2"
fi

if [[ $1 == "push" || $2 == "push" || $3 == "push" ]]; then
    push_flag=true
fi

for d in "${projects[@]}"; do
    cd "$d"
    echo ".............. $d ............."

    # Checkout the specified local branch
    git fetch upstream "$upstream_branch"
    git checkout "$local_branch"
    
    # Rebase with the specified upstream branch
    if ! git rebase "upstream/$upstream_branch"; then
        echo -e "${RED}Rebase failed for upstream/$upstream_branch. Skipping push.${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        cd ../
        continue
    fi
    
    # If push_flag is true, push to origin
    if [[ $push_flag == true ]]; then
        echo "Pushing into origin '$local_branch'"
        git push origin "$local_branch"
    fi


    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done

# Example command: update.sh cm push test-branch
