#!/bin/bash

# Search commit by user or email in all git repositories

source $(dirname $0)/config

if [ $# -eq 0 ]; then
    user=$myemail
else
    user="$1"
fi

find $workdir -type d -name '.git' -print0 2>/dev/null | sort -z | while read -d $'\0' folder; do
    cd $folder
    cmd=$(git --no-pager log --no-merges --pretty=oneline --color=always --author=$user -i)
    if [[ $cmd ]]; then
        echo "--------------------------------------------------------------------------------"
        echo ${folder::-5} | sed 's:.*/::'
        echo "--------------------------------------------------------------------------------"
        echo "$cmd"
        echo
    fi
done

