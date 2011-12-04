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
    ${GIT} pull origin master
    ${GIT} submodule update
    popd > /dev/null
    exit 0
fi

${GIT} clone git://github.com/maximeh/dotfiles.git ${DOTFILES}
pushd "${DOTFILES}" > /dev/null

#Init submodule
${GIT} submodule init
${GIT} submodule update

# Create symlink
ln -s ${DOTFILES}/vimrc ${HOME}/.vimrc
ln -s ${DOTFILES}/vim ${HOME}/.vim
ln -s ${DOTFILES}/zshrc ${HOME}/.zshrc
ln -s ${DOTFILES}/screenrc ${HOME}/.screenrc
ln -s ${DOTFILES}/irssi ${HOME}/.irssi
ln -s ${DOTFILES}/bin ${HOME}/bin

popd > /dev/null
exit 0

