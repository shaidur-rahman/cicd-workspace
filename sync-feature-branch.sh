#!/bin/bash

# ANSI escape codes for colors
CYAN="\e[1;36m"
RED="\033[38;2;255;0;0m"
RESET="\e[0m"

dirc=/media/shaidur/SSD2/git
ms="master"
br="experiment"

cd "$dirc"
projects=("netcourier-parent" "metafour-cloud" "metafour-auth" "netcourier-models" "netcourier-ng" "netcws-client" "netcws-client-mf" "netcws-client-ng" "netcws-client-cloud" "netcourier-api" "netcourier-jobimport" "netcourier-recon" "netcourier-integration" "netcourier-blend" "netcourier-shopping-cart" "netcourier-booking" "netcourier-cloud" "netcourier-online" "netcourier-data" "netcourier-rs" "netcourier-exchange" "netcourier" "mafv2")


pwd

for d in "${projects[@]}"; do
    cd "$d"
    echo -e $"..............${CYAN}$d${RESET} ............."

	git fetch upstream "$ms" && git fetch origin "$br"

    if ! git checkout "$br"; then
        echo -e "${RED}Checkout failed for $d. Skipping...${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        cd ../
        continue
	fi

	echo $"Rebasing with 'upstream/$ms'"
    if ! git rebase "upstream/$ms"; then
        echo -e "${RED}Rebase failed for $d. Skipping...${RESET}"
        echo "--------------------------------"
        echo ""
        echo ""
        cd ../
        continue
	fi

# If push provided in the command line then pushing into origin
    if [[ ! -z $1 && $1 = "push" ]]; then
        git push origin "$br" -f
    fi
    
    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done

