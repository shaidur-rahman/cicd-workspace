#!/bin/bash

# ANSI escape codes for colors
CYAN="\e[1;36m"
RED="\033[38;2;255;0;0m"
RESET="\e[0m"

dirc=/home/shaidur/git

cd "$dirc"
projects=("netcourier-parent" "metafour-cloud" "metafour-auth" "netcourier-models" "netcourier-ng" "netcws-client" "netcws-client-mf" "netcws-client-ng" "netcws-client-cloud" "netcourier-api" "netcourier-jobimport" "netcourier-recon" "netcourier-integration" "netcourier-blend" "netcourier-booking" "netcourier-cloud" "netcourier-online" "netcourier-data" "netcourier-rs" "netcourier-exchange" "netcourier" "mafv2")

for d in "${projects[@]}"; do
    cd "$d"
    echo $"..............${RED}$d${RESET} ............."
	
	git checkout nc-release-8-48

	#git fetch upstream nc-release-10
#	git fetch upstream nc-release-8-48
#	git fetch upstream nc-release-8-48
#	git fetch upstream

#	git rebase upstream/master
	if ! git rebase upstream/master; then
        echo -e "${RED}Rebase failed for $d. Skipping push.${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        cd ../
        continue
    fi

#	git reset --hard upstream/nc-release-8-49

#	echo $"Merging with 'upstream/$merge_with'"
#	git merge --no-edit upstream/nc-release-8-49

    if [[ ! -z $1 && $1 = true ]]; then
        git push origin NC-5414
    fi
    
    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done

