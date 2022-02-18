#!/bin/bash

# Search commit by message in all git repositories

source $(dirname $0)/config

find $workdir -type d -name '.git' -print0 2>/dev/null | sort -z | while read -d $'\0' folder; do
    cd $folder
    cmd=$(git --no-pager log --no-merges --pretty=oneline --color=always --grep="$1")
    if [[ $cmd ]]; then
        echo "--------------------------------------------------------------------------------"
        echo ${folder::-5} | sed 's:.*/::'
        echo "--------------------------------------------------------------------------------"
        echo "$cmd"
        echo
    fi
done

