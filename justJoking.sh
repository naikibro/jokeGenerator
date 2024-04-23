#!/bin/bash

# Path to the README and jokes files
README="README.md"
JOKES="jokes.txt"

# Check if the README and jokes files exist
if [[ ! -f "$README" || ! -f "$JOKES" ]]; then
    echo "Error: Required files README.md or jokes.txt not found."
    exit 1
fi

# Randomly select a joke
RANDOM_JOKE=$(shuf -n 1 "$JOKES")

# Replace the fourth line of README with the selected joke
sed -i "4s/.*/$RANDOM_JOKE/" "$README"

echo "Line 4 of README.md has been replaced with a random joke."

