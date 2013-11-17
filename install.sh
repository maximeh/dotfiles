#!/bin/bash

set -e

GIT=$(git --version)
DOTFILES_DIR="$HOME/.dotfiles"
[ -z "$GIT" ] && echo "Please install git" && exit 1

if [ ! -d "$DOTFILES_DIR" ]; then
  # If we're on a Mac execute hack.sh
  [ "$(uname)" = "Darwin" ] && "$DOTFILES_DIR/osx.sh"
  git clone --recursive git://github.com/maximeh/dotfiles.git "$DOTFILES_DIR"
fi

pushd "$DOTFILES_DIR" > /dev/null

# Update
git submodule init
git submodule update
git submodule foreach git pull origin master

# Create symlink for dotfiles
for file in gitconfig vimrc mutt vim zshrc ncmpcpp screenrc irssi tmux.conf Xresources i3 urxvt; do
    [ -h "$HOME/.$file" ] && rm "$HOME/.$file"
    # File have not been installed by us. Don't touch it.
    [ -f "$HOME/.$file" ] && continue
    ln -s "$DOTFILES_DIR/$file" "$HOME/.$file"
done
[ -h "$HOME/bin" ] && rm "$HOME/bin"
ln -s "$DOTFILES_DIR/bin" "$HOME/bin"

# Special case for SSH, don't want to symlink, just copy the config
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -p "$HOME/.ssh/tmp"
  cp "$DOTFILES_DIR/ssh/config" "$HOME/.ssh"
fi

popd > /dev/null
exit 0
