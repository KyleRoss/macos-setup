# macos-setup
My MacOS development environment setup scripts to help ease the pain of setting up a new Mac.

## Important Notes

**PLEASE READ these important notes before using this script!**

1. This script sets up a Mac based on my liking and opinions and may not be for everyone. I'd suggest forking this repo and making changes based on your preferences.
2. You should only run this script on a fresh installation of MacOS, although it will work on established installations as well. I'd suggest only running portions of the script instead of the whole thing. With a fresh installation of MacOS, you won't lose anything if something causes issues.
3. This script was written for MacOS 13.1 Ventura. Older (and possibly future) MacOS versions will not work properly.
4. I will not accept PRs or issues that are opinion-based. This was ultimately written for my needs, but I am open to fixes or improvements!
5. I hold no liability if this script causes issues to your Mac. Use at your own risk! *Before you bork, make a fork.*



## Usage

1. Clone the repo locally, preferably to your home directory:
   ```shell
   git clone git@github.com:KyleRoss/macos-setup.git
   ```

2. Run the script:
   ```shell
   ./setup.sh
   ```

3. Follow the prompts and restart your machine once completed!



## Overview

This script does a lot, so I'd recommend reading through the high-level stuff this does.

When running the script, you will be first prompted for your password. This is so you only need to `sudo` once.

### Tasks

The script is split up into a few tasks you can skip if desired.

#### 1. Tools and Applications

This will install various tools and applications needed for my dev environment.

- XCode CLI Tools
- Homebrew
- NVM
  - Latest LTS version of Node
- Oh My ZSH with plugins:
  - ZSH Autosuggestions
  - ZSH Syntax Highlighting
  - Powerline + Inconsolata font for Powerline
- Creates custom `.zshrc` and `.profile` files in the home directory.
- Installs items from the `Brewfile`:
  - Various fonts include Fira Code, Inter, Nunito, Open Sans, and Montserrat.
  - Applications:
    - iTerm2
    - Google Chrome
    - VSCode
    - Docker
    - Cyberduck
    - GPG Suite
    - Grammarly Desktop
    - Typora
    - Slack
    - DiffMerge
- Installs `npm-check` globally.

#### 2. System Preferences

Makes a ton of changes to preferences for MacOS and various applications. See `scripts/defaults.sh` for a full list. Most changes are commented within the file.

#### 3. SSH Key

Allows you to generate an SSH key. Skip this if you already have an SSH key or will be using a different key.

#### 4. Cleanup

Various cleanup tasks such as:

- Reset launchpad applications for resorting.
- Ensure Oh My ZSH is up-to-date.
- Upgrade, update, and clean up Brew.

### Completion

After completing the tasks, the script will create a `projects` directory within your home directory. You will then be prompted to restart your computer (highly recommended). **NOTE:** MacOS may *feel* broken after the script runs, but ensure that a reboot will get everything working again.

Once you've rebooted, you are free to delete the cloned repo on your machine:

```
rm -rf ~/macos-setup
```



## Credits

A lot of inspiration (and some code) came from various MacOS setup scripts available on Github.

- https://github.com/michaelschwobe/mac-dev-setup
