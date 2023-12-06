# My personal zshrc file

## Summary

An elegant Zsh prompt with current user, machine name, virtual environment, current directory, and time (with current timezone).

![screenshot](doc/screenshot2.png)

## Install

### Prerequisites

- [Zsh](https://www.zsh.org) should be installed (v5.0.8 and newer).
- `curl` or `wget` should be installed

### Basic installation
```bash
# Make sure zsh is installed (on Debian based Linux distro):
zsh --version || sudo apt install zsh
# Backup your previous version, if any:
cp ~/.zshrc ~/.zshrc.old.bak
# Download my zshrc:
curl -o .zshrc https://raw.githubusercontent.com/VideoCurio/MyZSH/master/zshrc
# Start it:
zsh
# Source it:
source $HOME/.zshrc
```

### Make ZSH your default shell:
```bash
sudo chsh -s /bin/zsh $USER
```
or modify manually the file `/etc/passwd` and reboot your computer.

## Features

- Custom theme and color prompt.
- Red prompt if you are logged as root.
- Modern command completion system based on your shell history and command help.
- `update` will do a complete `apt` update and upgrade, and also a flatpak update. Modify it on non Debian based distro.
- `history` show the complete history with timestamp.
- Auto updated terminal window title.

### Notes

Tested on Debian stable with Gnome default terminal.

## Authors
© 2023 David BASTIEN for videocurio.com<br>
This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see [GNU license](http://www.gnu.org/licenses/).
