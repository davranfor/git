#!/bin/bash

# Print current branch in all git repositories

source $(dirname $0)/config

red='\033[0;31m'    # Color red
def='\033[0m'       # No color

if [ -t 1 ]; then
    # Running from a terminal
    fmt="${red}%s${def}"
else
    # Running through a pipe
    fmt="%s"
fi

find $workdir -type d -name '.git' -print0 2>/dev/null | sort -z | while read -d $'\0' folder; do
    cd $folder
    printf "$fmt " $(sed 's:.*/::' <<< ${folder::-5})
    git rev-parse --abbrev-ref HEAD
done

