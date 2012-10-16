#!/bin/bash

set -x
set -e

# Get them
GIT=$(which git)
DOTFILES="$HOME/.dotfiles"

[ -f "$GIT" ] || $(echo "Please install git -> apt-get install git" && exit 1)

if [ -d "$DOTFILES" ]; then
    pushd "$DOTFILES" > /dev/null
    # Update them
    $GIT submodule init
    $GIT submodule update
    $GIT pull --recurse-submodules origin master
    popd > /dev/null
    exit 0
fi

$GIT clone --recursive git://github.com/maximeh/dotfiles.git "$DOTFILES"
pushd "$DOTFILES" > /dev/null

# Create symlink
for file in vimrc vim zshrc screenrc irssi; do
    [ -h "$HOME/.$file" ] && rm "$HOME/.$file"
    ln -s "$DOTFILES/$file" "$HOME/.$file"
done
# Special case for SSH, don't want to symlink, just copy the config
[ ! -d "$HOME/.ssh" ] && mkdir -p "$HOME/.ssh"
cp "$DOTFILES/ssh/config" "$HOME/.ssh"

[ -h "$HOME/bin" ] && rm "$HOME/bin"
ln -s "$DOTFILES/bin" "$HOME/bin"

# If we're on a Mac execute hack.sh
[ "$(uname)" = "Darwin" ] && "$DOTFILES/osx.sh"

# Update the font cache for Linux
# Mac OS users should double click on the font to install it.
[ "$(uname)" = "Linux" ] && fc-cache -vf
[ "$(uname)" = "Darwin" ] && echo "Please install fonts in the .fonts directory"

popd > /dev/null
exit 0

