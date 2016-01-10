autoload -Uz compinit
compinit
autoload -U edit-command-line
autoload -U zmv
zle -N edit-command-line
zle -N zle-line-init

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

bindkey -e
bindkey '\e[1;5C' forward-word            # C-Right
bindkey '\e[1;5D' backward-word           # C-Left
bindkey '\e[2~'   overwrite-mode          # Insert
bindkey '\e[3~'   delete-char             # Del
bindkey '\e[5~'   history-search-backward # PgUp
bindkey '\e[6~'   history-search-forward  # PgDn
bindkey '^A'      beginning-of-line       # Home
bindkey '^D'      delete-char             # Del
bindkey '^E'      end-of-line             # End
bindkey '^R'      history-incremental-pattern-search-backward
bindkey "^[[7~" beginning-of-line
bindkey "^[[8~" end-of-line

setopt always_to_end
setopt append_history
setopt auto_cd
setopt auto_pushd
setopt auto_remove_slash
setopt cdable_vars
setopt chase_links
setopt complete_aliases
setopt complete_in_word
setopt correct
setopt extended_glob
setopt extended_history
setopt glob_dots
setopt hash_list_all
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt list_ambiguous
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt share_history

unsetopt beep
unsetopt bg_nice
unsetopt hist_beep
unsetopt hup
unsetopt list_beep
unsetopt rm_star_silent

# Alias
alias ls="ls -F --color" # Color is handled differently on Linux
alias ..='cd ..' # Go up one directory
alias ...='cd ../..' # Go up two directories
alias ....='cd ../../..' # And for good measure
alias l='ls -lah' # Long view, show hidden
alias la='ls -AF' # Compact view, show hidden
alias ll='ls -lFh' # Long view, no hidden
alias grep='grep --color=auto' # Always highlight grep search term
alias psg='ps aux | grep -v grep | grep $1'   # See what's running
alias pswchan='ps xaopid,wchan:42,cmd'
alias ping='ping -c 5' # Pings with 5 packets, not unlimited
alias history='fc -l 1' # I want to see more the 16 history items
alias df='df -h' # Disk free, in gigabytes, not bytes
alias du='du -h -c' # Calculate total disk usage for a folder
alias mmv='noglob zmv -W'
unalias vi 2>/dev/null
alias vi='vim'
alias vim='vim -w ~/.vimlog "$@"'
# intercept stdout,stderr of PID
alias intercept='strace -ff -e trace=write -e write=1,2 -p'
alias duh="du "${@--xd1}" -h | sort -h" # sort dir in . based on their size
# fix_stty: restore terminal settings when they get completely screwed up
alias fix_stty='stty sane'
# osock: to display open sockets (the -P option to lsof disables port names)
alias osock='sudo lsof -i -P'
#ssh without check of the key
alias sshwk='ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias scpwk='scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no'
alias icdiff="icdiff --line-numbers --highlight"

# Functions
d2b() { for x in "$@"; do echo "obase=2;ibase=10;$x" | bc; done }
d2bs() { for x in "$@"; do d2b $x | rev | sed 's/.\{4\}/& /g' | rev; done }
h2b() { for x in "$@"; do echo "obase=2;ibase=16;$x:u" | bc; done }
h2bs() { for x in "$@"; do h2b $x | rev | sed 's/.\{4\}/& /g' | rev ; done }
b2d() { for x in "$@"; do echo "obase=10;ibase=2;$x" | bc; done }
h2d() { for x in "$@"; do echo "obase=10;ibase=16;$x:u" | bc; done }
d2h() { for x in "$@"; do echo "obase=16;ibase=10;$x:u" | bc; done }
b2h() { for x in "$@"; do echo "obase=16;ibase=2;$x:u" | bc; done }
calc() { echo "$*" | bc -l; } #define the co function to calculate
epoch() { date -d @$1; }
type() { echo "$*" | pv -qL 10; } #Simulate type char by char
digga() { dig +nocmd "$1" any +multiline +noall +answer }
# list available package listed by size in human forms
fatty () { dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | awk '{printf "%.3f MB ==> %s\n", $1/(1024), $2}' }
# get just the HTTP headers from a web page (and its redirects)
headers () { curl -I -L $@ ; }

function x {
        echo Extracting $1 ...
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
}

function resetfont {
  font_line=$(grep font "$HOME"/.Xresources)
  printf '\e]710;%s\007' "${font_line#*: }"
}

# show username@host if logged in through SSH
if [[ $SSH_CLIENT != '' || $SSH_TTY != '' ]]; then
  local username='%n@%m '
fi
precmd() {
  print -P "%F{yellow}$username%f%F{blue}%~%F{8}%f"
}
PROMPT="%(!.%F{red}.%F{magenta})❯%f "

export DIRSTACKSIZE=5
export EDITOR=vim
export HISTFILE=~/.histfile
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:* -h"
export HISTSIZE=1000000000
export KEYTIMEOUT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export PATH=$PATH:$HOME/bin:/usr/sbin:/sbin
# Show time a command took if over 5 sec
# https://github.com/bjeanes/dot-files/commit/1ae5bc72dac6d5f2cdfbf5a48fdf140c5d085986
export REPORTTIME=5
export SAVEHIST=$HISTSIZE
export TIMEFMT="%*Es total, %U user, %S system, %P cpu"
export TZ=/usr/share/zoneinfo/Europe/Paris
export VISUAL=vim

# Source machine file for specific stuff
if [ -f $HOME/.$(uname -n) ]; then
  source $HOME/.$(uname -n)
fi
