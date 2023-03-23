#!/usr/bin/env bash
#####################################################################
# Install various tools for MacOS                                   #
#####################################################################

source $SCRIPTS_DIR/_utils.sh

e_message "Installing Tools"

### XCODE CLI TOOLS #################################################
if has_command "xcode-select"; then
  e_pending "Installing xcode-select (CLI tools)"
  xcode-select --install
  test_command "xcode-select"
fi

### HOMEBREW ########################################################
if ! has_command "brew"; then
  e_pending "Installing brew (Homebrew)"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew doctor
  test_command "brew"
fi

### NVM #############################################################
if ! has_command "nvm"; then
  e_pending "Installing nvm"
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
  test_command "nvm"
fi

### OH MY ZSH #######################################################
if has_command "zsh"; then
  if ! has_path ".oh-my-zsh"; then
    e_pending "Installing Oh My Zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    test_path ".oh-my-zsh"
  fi
fi

### OH MY ZSH PLUGINS ###############################################
if has_path ".oh-my-zsh"; then
  if ! has_path ".oh-my-zsh/custom/plugins/zsh-autosuggestions"; then
    e_pending "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  fi

  if ! has_path ".oh-my-zsh/custom/plugins/zsh-syntax-highlighting"; then
    e_pending "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  fi

  e_pending "Installing Powerline"
  pip3 install --user powerline-status

  e_pending "Installing Powerline font"
  sh -c "$(git clone https://github.com/powerline/fonts.git --depth=1)"
  sh -c "./fonts/install.sh Inconsolata"
  rm -rf ./fonts
fi

### ZSHRC + PROFILE #################################################
if has_command "zsh"; then
  e_pending "Setting up .zshrc file"
  echo -e "export PATH=\$PATH:$(python3 -m site --user-base)/bin\nexport ZSH=\"$HOME/.oh-my-zsh\"\nPY_SITE_PACKAGES=\"$(python3 -m site --user-site)\"\n" > $HOME/.zshrc
  cat $BASE_DIR/dotfiles/.zshrc >> $HOME/.zshrc

  e_pending "Setting up .profile file"
  cat $BASE_DIR/dotfiles/.profile > $HOME/.profile

  source $HOME/.zshrc
fi

### BREWFILE ########################################################
if has_command "brew"; then
  e_pending "Installing items from Brewfile"
  brew bundle --no-lock --file=$BASE_DIR/Brewfile
fi

### NODE ############################################################
if has_command "nvm"; then
  e_pending "Installing Node with nvm"
  nvm install --lts --default --latest-npm
fi

### NPM PACKAGES ####################################################
if has_command "npm"; then
  e_pending "Installing npm packages"
  npm install -g npm-check
fi

e_success "Tools and Applications installed successfully!"
