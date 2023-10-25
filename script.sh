#!/bin/sh
#
# At this stage I suppose you have brew and git installed
#

# Install tmux
brew install tmux

# Install tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install neovim
brew install neovim

# Install yabai
brew install yabai

# Install skhd
brew install koekeishiya/formulae/skhd
skhd --start-service


# Copy config
cp -r ./.config/ ~/.config/

# Copy tmux config
cp .tmux.conf ~/.tmux.conf

# Copy skhd config file
cp .skhdrc ~/.skhdrc

# Copy .zshrc config file
cp .zshrc ~/.zshrc

# Copy p10k config
cp .p10k.zsh ~/.p10k.zsh
