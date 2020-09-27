#!/bin/bash
REMOTES=`git remote -v | grep "fetch" | wc -l`
if [ $REMOTES -eq 1 ]
then
    git remote add upstream git@gitlab.tugraz.at:esp-ws20/hello_world.git
fi

UNSTAGED=`git status --porcelain | wc -l`
if [ $UNSTAGED -ne 0 ]
then
    echo "unstaged changed. Please run make upload first"
    exit 1
fi

`git pull upstream master`
