#!/bin/bash

SCRIPT_PATH="$(dirname $(pwd))/jokeGenerator/contribute.sh"
if [ ! -f "$SCRIPT_PATH" ]; then
  echo "Error: Script not found at $SCRIPT_PATH"
  exit 1
fi

# Make sure the script is executable
chmod +x "$SCRIPT_PATH"

# Add the cron job
(crontab -l 2>/dev/null; echo "0 17 * * * /bin/bash $SCRIPT_PATH") | crontab -
(crontab -l 2>/dev/null; echo "0 7 * * * /bin/bash $SCRIPT_PATH") | crontab -
echo "Cron job has been added to run contribute.sh every day at 7:00 and 17:00."
