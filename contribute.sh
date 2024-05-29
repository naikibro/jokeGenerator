#!/bin/bash

# Exit on any error
set -e

echo "Checking out master branch from origin."
git fetch origin
git checkout -f origin/master

# Function to create a unique branch name
create_unique_branch_name() {
  base_name=$1
  index=1
  new_branch="$base_name"
  
  while git show-ref --quiet refs/heads/"$new_branch"; do
    new_branch="${base_name}-${index}"
    index=$((index + 1))
  done
  
  echo "$new_branch"
}

# Read a random branch name from branches.txt
base_branch_name=$(shuf -n 1 branches.txt)
new_branch=$(create_unique_branch_name "$base_branch_name")

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
