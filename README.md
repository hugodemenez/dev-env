# My developer config

## Purpose
As I started my developer journey with VS Code, I realized that it was not customized to meet my needs in any way. In fact, I couldn't navigate through files and easily switch terminals with shortcuts.
This pain point led me to start working with Vim (specifically Neovim, since Vim isn't going to progress further at this stage).

I had previous experience working with Vim on Ubuntu servers to make quick code changes; however, it isn't suitable for long coding sessions.

I soon realized that I could significantly increase my productivity by using a custom development configuration tailored to my needs.

This repository contains most of my configuration files that I use on my MacBook Pro M1 (2021).

If you are on a Linux system, you won't encounter any difficulty in using the same configuration.

## Config

There are different files 
- .tmux.conf is the file that configure shortcuts that I use in tmux
- .config/nvim/init.lua is the file that configure neovim (theme, shortcut, plugins)
- .zshrc is the file that configure the shell (especially maps the vim to nvim command)
- .config/yabai/yabairc is the file that configure shortcuts used 

For faster implementation. a bash script is in the repo
To run the bash script, use `chmod 755 script.sh`
Then use `./script.sh`

> Last update on 9 Nov 2023
