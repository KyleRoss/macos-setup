#!/usr/bin/env bash
#####################################################################
# MACOS DEVELOPMENT ENVIRONMENT SETUP SCRIPT                        #
# ----------------------------------------------------------------- #
# This script helps ease the setup of a new development environment #
# on a Mac.                                                         #
# ----------------------------------------------------------------- #
# Author: Kyle Ross                                                 #
#####################################################################

export BASE_DIR=$(dirname $(readlink -f $0))
export SCRIPTS_DIR=$BASE_DIR/scripts

source $SCRIPTS_DIR/_utils.sh

clear

e_message "Starting MacOS Setup Script"

# ask for the administrator password upfront
sudo -v

# keep-alive: update existing `sudo` time stamp until script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if get_consent "Install tools and applications?"; then
  source $SCRIPTS_DIR/tools.sh
fi

if get_consent "Run system preferences setup?"; then
  source $SCRIPTS_DIR/defaults.sh
fi

if get_consent "Setup SSH key?"; then
  source $SCRIPTS_DIR/ssh.sh
fi

if get_consent "Run cleanup and optimizations?"; then
  source $SCRIPTS_DIR/cleanup.sh
fi

e_pending "Creating projects directory"
mkdir -p $HOME/projects

e_success "Setup complete!"


if get_consent "Would you like to restart your computer now?"; then
  sudo shutdown -r now
else
  e_message "Please restart your computer to complete the setup process."
fi
