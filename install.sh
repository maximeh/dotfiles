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
    $GIT submodule -q foreach git pull -q origin master
    popd > /dev/null
    exit 0
fi

$GIT clone --recursive git://github.com/maximeh/dotfiles.git "$DOTFILES"
pushd "$DOTFILES" > /dev/null

# Create symlink
for file in gitconfig vimrc vim zshrc screenrc irssi; do
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

popd > /dev/null
exit 0

