# Go to git working directory
dirc=/home/shaidur/git
cd "$dirc"

projects=("netcourier-parent" "metafour-cloud" "metafour-auth" "netcourier-models" "netcourier-ng" "netcws-client" "netcws-client-mf" "netcws-client-ng" "netcws-client-cloud" "netcourier-api" "netcourier-jobimport" "netcourier-recon" "netcourier-integration" "netcourier-blend" "netcourier-booking" "netcourier-cloud" "netcourier-online" "netcourier-data" "netcourier-rs" "netcourier-exchange" "netcourier" "mafv2")

for d in "${projects[@]}"; do
    originLink="git@github.com:shaidur-rahman-mfa/$d.git";
    upstreamLink="git@github.com:Metafour-Int/$d.git";

    echo $"Cloning: $originLink"
    git clone "$originLink"
    
    cd "$d"
    echo $"Adding upstream remote: $upstreamLink"
    git remote add upstream "$upstreamLink"

    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done
