dirc=/home/shaidur/git
cd "$dirc"

projects=("netcourier-parent" "metafour-cloud" "metafour-auth" "netcourier-models" "netcourier-ng" "netcws-client" "netcws-client-mf" "netcws-client-ng" "netcws-client-cloud" "netcourier-api" "netcourier-jobimport" "netcourier-recon" "netcourier-integration" "netcourier-blend" "netcourier-booking" "netcourier-cloud" "netcourier-online" "netcourier-data" "netcourier-rs" "netcourier-exchange" "netcourier" "mafv2")

for d in "${projects[@]}"; do
    cd "$d"
    
    echo $"..............$d ............."

    # if variable empty or 'cm' then checkout master or just update the branch with upstream/master    
    if [[ -z $1 || $1 = "cm" || $1 = "push" ]]; then
        git checkout master
    fi
    git fetch upstream master
    git rebase upstream/master
    
    # if command is 'push' and branch name specified, then it will pushed into that branch
    if [[ $1 = "push" ]]; then
        branch="master"
        if [[ -n $2 ]]; then
            branch="$2";
        fi

        echo $"Pushing into origin '$branch'"
        git push origin "$branch"
    fi

    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done

# Example command: update.sh cm push test-branch
