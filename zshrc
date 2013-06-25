autoload -Uz compinit
compinit
autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

setopt append_history share_history
setopt hist_ignore_dups histignorealldups
setopt HIST_FIND_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt EXTENDED_HISTORY
setopt auto_remove_slash
setopt glob_dots
setopt rmstarwait
setopt chase_links
setopt auto_pushd
export dirstacksize=5
setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome
setopt cdablevars
setopt extended_glob
setopt COMPLETE_IN_WORD
unsetopt list_ambiguous
unsetopt beep
unsetopt hist_beep
unsetopt list_beep

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
alias ping='ping -c 5' # Pings with 5 packets, not unlimited
alias history='fc -l 1' # I want to see more the 16 history items
alias df='df -h' # Disk free, in gigabytes, not bytes
alias du='du -h -c' # Calculate total disk usage for a folder
unalias vi 2>/dev/null
alias vi='vim'
alias rec='ffmpeg -f x11grab -r 25 -s 800x600 -i :0.0' # record desk to a file
# intercept stdout,stderr of PID
alias intercept='strace -ff -e trace=write -e write=1,2 -p'
alias duh="du "${@--xd1}" -h | sort -h" # sort dir in . based on their size
# fix_stty: restore terminal settings when they get completely screwed up
alias fix_stty='stty sane'
# osock: to display open sockets (the -P option to lsof disables port names)
alias osock='sudo lsof -i -P'

# Functions
calc() { echo "$*" | bc -l; } #define the co function to calculate
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

typeset -Ag FX FG BG
FX=(
    reset     "[00m"
    bold      "[01m" no-bold      "[22m"
    italic    "[03m" no-italic    "[23m"
    underline "[04m" no-underline "[24m"
    blink     "[05m" no-blink     "[25m"
    reverse   "[07m" no-reverse   "[27m"
)

for color in {000..255}; do
    FG[$color]="[38;5;${color}m"
    BG[$color]="[48;5;${color}m"
done

local name_bold="%{$FX[bold]$FG[205]%}%n%{$FX[reset]%}"
local name_root_bold="%{$FX[bold]$FG[001]%}%n%{$FX[reset]%}"
local host_bold="%{$FX[bold]$FG[208]%}%m%{$FX[reset]%}"
local dir_bold="%{$FX[bold]$FG[012]%}%2c%{$FX[reset]%}"

if [ "`id -u`" -eq 0 ]; then
    PS1="┌─${name_root_bold} at ${host_bold} in ${dir_bold}
└─╼ "
else
    PS1="┌─${name_bold} at ${host_bold} in ${dir_bold}
└─╼ "
fi

# Show time a command took if over 5 sec
# https://github.com/bjeanes/dot-files/commit/1ae5bc72dac6d5f2cdfbf5a48fdf140c5d085986
export REPORTTIME=5
export TIMEFMT="%*Es total, %U user, %S system, %P cpu"
export HISTSIZE=32768
export SAVEHIST=32768
export HISTFILESIZE=$HISTSIZE
# Make some commands not show up in history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:* -h"
# Fichier où est stocké l'historique
export HISTFILE=~/.histfile
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export TZ=/usr/share/zoneinfo/Europe/Paris
export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:$HOME/bin:/usr/sbin:/sbin
# Source machine file for specific stuff
source $HOME/.$(uname -n)
