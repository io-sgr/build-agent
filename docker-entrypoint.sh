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

source $HOME/.bash_profile

exec "$@"
