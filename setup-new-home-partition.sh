#!/bin/bash

if [ ! -e /bin/zsh ]
then
	echo "Installing zsh"
	sudo pacman -S zsh
fi

# Install oh-my-zsh
echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


echo "Linking .zshrc"
# Link .zshrc
if [ -e ~/.zshrc ]
then
	echo "Created backup ~/.zshrcbak"
	mv ~/.zshrc ~/.zshrcbak
fi
ln -s ./zsh/.zshrc ~/.zshrc

source ~/.zshrc

# Link .vimrc
echo "Linking .vimrc"
if [ -e ~/.vimrc ]
then
	echo "Created backup ~/.vimrc"
	mv ~/.vimrc ~/.vimrcbak
fi
ln -s ./vim/.vimrc ~/.vimrc
echo "Installing plugins"
vim +PlugClean +PlugUpdate 

echo "Linking ctags config"
ln -s ~/dotfiles/.ctags.d ~/.ctags.d


# Link i3
echo "Linking i3 configs"
if [ -e ~/.config/i3/config ]
then
	echo "Created backup ~/.config/i3/configbak"
	mv ~/.config/i3/config ~/.config/i3/configbak
fi
if [ -e ~/.i3/config ]
then
	echo "Created backup ~/.i3/configbak"
	mv ~/.i3/config ~/.i3/configbak
	mkdir .config/i3
fi
ln -s ./i3/config ~/.config/i3/config


if [ -e ~/.config/i3status/config ]
then
	echo "Created backup ~/.config/i3status/configbak"
	mv ~/.config/i3status/config ~/.config/i3status/configbak
fi
ln -s .i3status/config ~/.config/i3status/config

# Installing some software
sudo pacman -S gnome-screenshot
sudo cp scripts/gscrot /usr/bin/gscrot
sudo chmod +x /usr/bin/gscrot

echo "Finished"
