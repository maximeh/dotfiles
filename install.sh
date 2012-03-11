#!/bin/bash

set -x
set -e

# Get them
GIT=$(which git)
DOTFILES="$HOME/.dotfiles"

[ -f ${GIT} ] || $(echo "Please install git -> apt-get install git" && exit 1)

if [ -d ${DOTFILES} ]; then
    pushd "${DOTFILES}" > /dev/null
    # Update them    
    ${GIT} pull --recurse-submodules origin master
    popd > /dev/null
    exit 0
fi

${GIT} clone --recursive git://github.com/maximeh/dotfiles.git ${DOTFILES}
pushd "${DOTFILES}" > /dev/null

# Create symlink
for file in vimrc vim zshrc screenrc irssi; do
    [ -h "${HOME}/.${file}" ] && rm ${HOME}/.${file}
    ln -s ${DOTFILES}/${file} ${HOME}/.${file}
done
[ -h "${HOME}/bin" ] && rm ${HOME}/bin
ln -s ${DOTFILES}/bin ${HOME}/bin

popd > /dev/null
exit 0

