#!/bin/bash

# Get the current working directory
CURRENT_DIR=$(pwd)

# Define the path to the script
SCRIPT_PATH="$CURRENT_DIR/../contribute.sh"
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: Script not found at $SCRIPT_PATH"
  exit 1
fi

# Make sure the script is executable
chmod +x "$SCRIPT_PATH"

# Add the cron job
(crontab -l 2>/dev/null; echo "0 17 * * * $SCRIPT_PATH") | crontab -
echo "Cron job has been added to run contribute.sh every day at 17:00."
