#!/bin/bash

# Print current branch in all git repositories

source $(dirname $0)/config

red='\033[0;31m'
noc='\033[0m' # No Color

find $workdir -type d -name '.git' -print0 2>/dev/null | sort -z | while read -d $'\0' folder; do
    cd $folder
    printf "${red}%s${noc} " $(sed 's:.*/::' <<< ${folder::-5})
    git rev-parse --abbrev-ref HEAD
done

