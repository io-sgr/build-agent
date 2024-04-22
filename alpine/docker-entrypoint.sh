#!/usr/bin/env bash

# Exit script on error
set -e

# Function to handle SIGTERM signal (graceful shutdown)
term_handler() {
  echo 'Signal received, stopping...'
  exit 0
}

# Trap SIGTERM signal
trap 'term_handler' SIGTERM

# Init sdkman and jenv
source $HOME/.bash_profile

# If /docker-entrypoint.d/ exists and is a directory
if [ -d "/docker-entrypoint.d/" ]; then
  # For each file in /docker-entrypoint.d/
  for entrypoint in /docker-entrypoint.d/*; do
    case "$entrypoint" in
      *.sh)
        # If the file is a shell script, run it
        echo "Running $entrypoint"
        . "$entrypoint"
        ;;
      *)
        echo "Ignoring $entrypoint"
        ;;
    esac
  done
fi

# Execute the main command
exec "$@"
