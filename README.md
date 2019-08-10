# Dotfiles

![Screenshot](./scrot.png)

Symlinks are managed with `GNU Stow`.

Run the following in `$dotfiles/configs` to setup all symlinks:

```bash
stow * -t $HOME -v
```

The dotfiles contain configurations for:
* bash
* bin
* compton
* ctags
* dircolors-gruvbox
* dunst
* emacs
* flake
* i3
* i3status
* polybar
* pylint
* rofi
* termite
* tmux
* vim
* zathura
* zsh
