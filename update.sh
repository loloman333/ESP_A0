#!/bin/bash
REMOTES=`git remote -v | grep "fetch" | wc -l`
if [ $REMOTES -eq 1 ]
then
    git remote add upstream git@gitlab.tugraz.at:esp-ws20/hello_world.git
    git config pull.rebase false
fi

UNSTAGED=`git status --porcelain | wc -l`
if [ $UNSTAGED -ne 0 ]
then
    echo "unstaged changed. Please commit your changes first"
    exit 1
fi

git pull upstream master
