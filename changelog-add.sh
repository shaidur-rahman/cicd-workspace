#!/bin/bash

# Find the ChangeLog file regardless of its case, with or without the .txt extension
CHANGE_LOG_FILE=$(find . -maxdepth 1 -type f \( -iname "changelog" -o -iname "changelog.txt" \) -print -quit)

# Check if a ChangeLog file was found
if [ -z "$CHANGE_LOG_FILE" ]; then
    echo "No ChangeLog file found!"
    exit 1
fi

# Use the provided message or get the last commit message
if [ -n "$1" ]; then
    MESSAGE="$1"
else
    MESSAGE=$(git log -1 --pretty=%B | tr '\n' ' ' | sed 's/[[:space:]]*$//')
fi

# Get today's date in the format [07-Aug-2024]
TODAY=$(LC_TIME=en_US.UTF-8 date +"[%d-%b-%Y]")

# Modify the message to have the date on a separate line
FORMATTED_MSG="$TODAY\n* [SHR] $MESSAGE\n"

# Insert the formatted message at the top of the ChangeLog file
{ echo -e "$FORMATTED_MSG"; cat "$CHANGE_LOG_FILE"; } > temp_file && mv temp_file "$CHANGE_LOG_FILE"

# Add the changes to git
git add "$CHANGE_LOG_FILE"

# Commit the changes
git commit -m "Updated $CHANGE_LOG_FILE"

echo "$CHANGE_LOG_FILE updated and committed!"


# Other task to make a alias for this:

# 1. Make the Script Executable: chmod +x changelog-add.sh

# 2. Create an Alias:
# 	a. Run:			sudo gedit ~/.bashrc
# 	b. Add a line: 	alias clog='~/development/projects/cicd-workspace/changelog-add.sh'

# 3. Reload Your Shell Configuration: source ~/.bashrc  # or source ~/.zshrc

