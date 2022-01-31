#!/bin/bash

# Get all git commits since last tag

source $(dirname $0)/config

find $workdir -type d -name '.git' -print0 2>/dev/null | sort -z | while read -d $'\0' folder; do
    cd $folder
    cmd=$(git log $(git describe --tags --abbrev=0 2>/dev/null)..HEAD --oneline --color=always)
    if [[ $cmd ]]; then
        echo "--------------------------------------------------------------------------------"
        echo ${folder::-5} | sed 's:.*/::'
        echo "--------------------------------------------------------------------------------"
        echo "$cmd"
        echo
    fi
done

