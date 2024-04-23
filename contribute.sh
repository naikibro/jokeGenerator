#!/bin/bash

# Exit on any error
set -e

echo "Checking out master branch from origin."
git fetch origin
git checkout -f origin/master

# Select a random line from branches.txt for the new branch name
new_branch=$(shuf -n 1 branches.txt)
echo "Creating and switching to new branch: $new_branch"
git checkout -b $new_branch
echo "Checked out to $new_branch and ready to proceed."

./justJoking.sh

git add .

# Select a random line from commits.txt for the commit message
commit_message=$(shuf -n 1 commits.txt)
git commit -m "$commit_message"
git push origin $new_branch

echo "Operations completed successfully."