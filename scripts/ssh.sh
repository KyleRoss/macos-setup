#!/usr/bin/env bash
#####################################################################
# Setup SSH key for the machine                                     #
#####################################################################

source $SCRIPTS_DIR/_utils.sh

e_message "Setting up new SSH key"

# make sure the .ssh directory exists
mkdir -p $HOME/.ssh

get_input "What is your Github email address?"

# generate a new ssh key
ssh-keygen -f $HOME/.ssh/id_ed25519 -N "" -t ed25519 -C $LAST_INPUT

# start the ssh agent in the background
eval "$(ssh-agent -s)"

# add the ssh config
cat $BASE_DIR/configs/ssh_config > $HOME/.ssh/config

# add the ssh key to the ssh agent
ssh-add $HOME/.ssh/id_ed25519

# copy the public key to the clipboard
pbcopy < ~/.ssh/id_ed25519.pub

e_message "SSH public key has been copied to the clipboard"

e_success "SSH key setup complete!"
