#!/bin/bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew and install it if missing
if test ! $(which brew)
then
  echo "Installing Homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew tap homebrew/versions
brew tap homebrew/dupes

# Make sure we’re using the latest Homebrew
brew update

# Upgrade any already-installed formulae
brew upgrade --all

apps=(
    coreutils
    moreutils
    findutils
    ffmpeg
    git
    git-lfs
    git-extras
    imagemagick
    rename
    ssh-copy-id
    speedtest_cli
    testssl
    webkit2png
    wget
    zopfli
)

brew install "${apps[@]}"

# Remove outdated versions from the cellar
brew cleanup