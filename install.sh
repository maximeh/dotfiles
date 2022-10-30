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

### Setup TouchID for sudo

# If TouchID for sudo is setup: use that instead.
if grep -q pam_tid /etc/pam.d/sudo; then
   echo "Configuring sudo authentication using TouchID: OK (already done)"
else
  if ls /usr/lib/pam | grep -q "pam_tid.so"; then
    echo "Configuring sudo authentication using TouchID: (may ask your sudo pwd)"
    PAM_FILE="/etc/pam.d/sudo"
    FIRST_LINE="# sudo: auth account password session"
    if grep -q pam_tid.so "$PAM_FILE"; then
      echo "OK"
    elif ! head -n1 "$PAM_FILE" | grep $Q "$FIRST_LINE"; then
      echo "$PAM_FILE is not in the expected format!"
    else
      TOUCHID_LINE="auth       sufficient     pam_tid.so"
      sudo sed -i .bak -e \
        "s/$FIRST_LINE/$FIRST_LINE\n$TOUCHID_LINE/" \
        "$PAM_FILE"
      sudo rm "$PAM_FILE.bak"
      echo "OK"
    fi
  fi
fi

exit 0
