#!/bin/bash

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
