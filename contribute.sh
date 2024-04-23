#!/bin/bash

# Exit on any error
set -e

echo "Checking out master branch from origin."
git fetch origin
git checkout -f origin/master

new_branch=$(shuf -n 1 branches.txt)
echo "Creating and switching to new branch: $new_branch"
git checkout -b $new_branch
echo "Checked out to $new_branch and ready to proceed."

./justJoking.sh

git add .

commit_message=$(shuf -n 1 commits.txt)
git commit -m "$commit_message"
git push origin $new_branch

echo "Creating pull request..."
gh pr create --base master --head "$new_branch" --title "Merge $new_branch" --body "Automated changes" --fill

echo "Merging pull request..."
gh pr merge "$new_branch" --admin --merge

# Update and reset local master branch
echo "Updating local master branch..."
git fetch origin
git checkout master
git reset --hard origin/master

echo "Operations completed successfully."
