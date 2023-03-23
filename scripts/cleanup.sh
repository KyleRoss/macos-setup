#!/usr/bin/env bash
#####################################################################
# Install various tools for MacOS                                   #
#####################################################################

source $SCRIPTS_DIR/_utils.sh

e_message "Running Cleanup"

### LAUNCHPAD #######################################################
e_pending "Re-sorting Launchpad applications"
defaults write com.apple.dock ResetLaunchPad -boolean true
killall Dock

### OH MY ZSH #######################################################
if has_path ".oh-my-zsh"; then
  e_pending "Updating oh-my-zsh"
  $ZSH/tools/upgrade.sh
fi

### HOMEBREW ########################################################
if has_command "brew"; then
  e_pending "Running brew update"
  brew update
  e_pending "Running brew upgrade"
  brew upgrade
  e_pending "Running brew doctor"
  brew doctor
  e_pending "Running brew cleanup"
  brew cleanup
fi

e_message "Cleanup complete!"
