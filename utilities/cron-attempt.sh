#!/bin/zsh

cd /home/jorres/custom-configs

# This has to be done with root privileges:
./update-configs.sh
git add .

# configure username and email of my root user to be the same as 
# my user who would have done this commit manually. This is for commit only!
git config --global user.email $(sudo -u jorres git config user.email)
git config --global user.name $(sudo -u jorres git config user.name) 

DAY=$(date +%F);
git commit -m "AUTO: data update $DAY"

# Push is done with regular user:
sudo -u jorres git push




# Check ssh connection from this script works as intended
# sudo -u jorres ssh -vT git@github.com
