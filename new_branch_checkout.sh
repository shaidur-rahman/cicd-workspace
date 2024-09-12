#!/bin/bash
# bash new_branch_checkout.sh -a new_branch_name -b target_source_branch -c projects_to_be_checkedout

while [[ $# -gt 0 ]]; do
    case "$1" in
        -a)
            new_branch_name="$2"
            shift 2
            ;;
        -b)
            target_source_branch="$2"
            shift 2
            ;;
        -c)
            projects_to_be_checkedout=("${@:2}")
            if [ -z "$projects_to_be_checkedout" ]; then
                echo "Parameter C is empty. Exiting."
                exit 1
            fi
            break
            ;;
        *)
            echo "Invalid option: $1"
            exit 1
            ;;
    esac
done

# Check if any required parameter is empty
if [ -z "$new_branch_name" ] || [ -z "$target_source_branch" ]; then
    echo "Parameter A or B is empty. Exiting."
    exit 1
fi

# Go to git working directory
dirc=~/git
cd "$dirc"

# Go to every projects specified by the parameter c
for project in "${projects_to_be_checkedout[@]}"; do
    cd "$project"
    echo $"..............$project ............."

    git fetch upstream
    git checkout -b $new_branch_name $target_source_branch
#    git branch --show-current
# The above line will print current branch name (remove comment if need to print)
    echo "--------------------------------"
    echo ""
    echo ""
    cd ../
done


#echo "Parameter A: $param_a"
#echo "Parameter B: $param_b"
#echo "Parameter C: ${param_c[@]}"  # To print all the data in the array 

