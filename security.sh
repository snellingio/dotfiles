#!/usr/bin/env bash

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until this has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Don't use your real name for your account as it'll show up as So-and-so's Macbook through sharing services to local networks.
sysctl kern.hostname=localhost
hostname -s localhost
scutil --set HostName localhost
scutil --set LocalHostName localhost
scutil --set ComputerName localhost

# Enforce hibernation and evict Filevault keys from memory instead of traditional sleep to memory
pmset -a destroyfvkeyonstandby 1
pmset -a hibernatemode 25

# Modify your standby and power nap settings. Otherwise, your machine may wake while in standby mode and then power off due to the absence of the FileVault key. 
pmset -a powernap 0
pmset -a standby 0
pmset -a standbydelay 0
pmset -a autopoweroff 0

# Enable the firewall
defaults write /Library/Preferences/com.apple.alf globalstate -bool true

# Enable logging
defaults write /Library/Preferences/com.apple.alf loggingenabled -bool true

# Enable stealth mode
defaults write /Library/Preferences/com.apple.alf stealthenabled -bool true

# Automatically allow signed software to receive incoming connections
defaults write /Library/Preferences/com.apple.alf allowsignedenabled -bool false

# Disable Captive Portal assistant utility
defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Set your screen to lock as soon as the screensaver starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Expose hidden files and Library folder in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true
chflags nohidden ~/Library

# Don't default to saving documents to iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable crash reporter (the dialog which appears after an application crashes and prompts to report the problem to Apple)
defaults write com.apple.CrashReporter DialogType none

# Disable Bonjour multicast advertisements
defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
