#!/bin/bash

if ! command -v stow &> /dev/null; then
    echo "warning: 'stow' is not available on this machine. Install through homebrew"
fi

if ! [ -f "/Applications/Secretive.app/Contents/MacOS/Secretive" ]; then
    echo "warning: 'Secretive' is not available on this machine. Install through homebrew"
fi

git submodule init
git submodule update
git submodule foreach git pull origin master

# Create symlink for dotfiles
for dir in */; do
	[ "${dir}" = ".git" ] && continue
	stow "${dir}"
done

mkdir -p "$HOME/.ssh/tmp"
cp "$DOTFILES_DIR/ssh/config" "$HOME/.ssh"

exit 0
