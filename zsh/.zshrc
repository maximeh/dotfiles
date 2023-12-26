autoload -Uz compinit edit-command-line zmv zrecompile
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
zle -N edit-command-line

# Make completion usable on NFS directories
# https://unix.stackexchange.com/questions/162078/stop-zsh-from-completing-parent-directories
zstyle ':completion:*' accept-exact-dirs true
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2

bindkey -e "^[b" forward-word      # ⌥→
bindkey -e "^[f" backward-word     # ⌥←
bindkey -v '^A' beginning-of-line       # Home
bindkey -v '^E' end-of-line             # End
bindkey -v '^R' history-incremental-pattern-search-backward

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
setopt correctall
setopt extended_glob
setopt extended_history
setopt glob_dots
setopt hash_list_all
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_verify
setopt inc_append_history
setopt list_ambiguous
setopt no_beep
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent
setopt pushd_to_home
setopt vi

unsetopt bg_nice
unsetopt hist_beep
unsetopt hup
unsetopt list_beep
unsetopt rm_star_silent

# Alias
alias ls="ls -F -G"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias l='ls -lsah'
alias ll='ls -lFh'
alias grep='grep --color=auto'
alias myip='curl https:/nova.m14n.dev/ip'
alias history='fc -il 1'
alias df='df -h'
alias du='du -h -c'
alias mmv='noglob zmv -W'
unalias vi 2>/dev/null
alias vi='vim'
alias duh="du "${@--xd1}" -h | sort -h"
alias g='git'

git-find-word() {
  git grep -l $1 | xargs -n1 git blame -f -n -w | grep $1 | sed "s/.\{9\}//" | sed "s/(.*)[[:space:]]*//"
}
alias todo='git-find-word "TODO"'
alias fixme='git-find-word "FIXME"'

# Functions
abs() { echo -n $PWD/$1 }
d2b() { for x in "$@"; do echo "obase=2;ibase=10;$x" | bc; done }
d2bs() { for x in "$@"; do d2b $x | rev | sed 's/.\{4\}/& /g' | rev; done }
h2b() { for x in "$@"; do echo "obase=2;ibase=16;$x:u" | bc; done }
h2bs() { for x in "$@"; do h2b $x | rev | sed 's/.\{4\}/& /g' | rev ; done }
b2d() { for x in "$@"; do echo "obase=10;ibase=2;$x" | bc; done }
h2d() { for x in "$@"; do echo "obase=10;ibase=16;$x:u" | bc; done }
d2h() { for x in "$@"; do echo "obase=16;ibase=10;$x:u" | bc; done }
b2h() { for x in "$@"; do echo "obase=16;ibase=2;$x:u" | bc; done }
fatty () { dpkg-query -Wf '${Installed-Size}\t${Package}\n' | sort -n | awk '{printf "%.3f MB ==> %s\n", $1/(1024), $2}' }
headers () { curl -I -L $@ ; }

x() {
        echo Extracting $1 ...
        if [ -f $1 ] ; then
          case $1 in
            *.tar.*|*.t*) tar xf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) rar x $1 ;;
            *.gz) gunzip $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
}

any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]] ; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2 ; return 1
    else
        ps xauwww | grep -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

# show username@host if logged in through SSH
if [[ $SSH_CLIENT != '' || $SSH_TTY != '' ]]; then
  local username='%n@%m '
fi
precmd() {
  print -P "%F{yellow}$username%f%F{blue}%~%F{8}%f"
}
PROMPT="%(!.%F{red}.%F{magenta});%f "

export DIRSTACKSIZE=5
export EDITOR=vim
export HISTFILE=~/.histfile
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:* -h"
export HISTSIZE=99999
export KEYTIMEOUT=1
export LANG="en_GB.UTF-8"
export LC_ALL="en_GB.UTF-8"
export LOCALE="en_GB.UTF-8"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin"
export PATH="$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin/:/usr/local/sbin/"
export PATH="$PATH:$HOME/.bin:$HOME/.local/bin"
export REPORTTIME=5
export SAVEHIST=$HISTSIZE
export TIMEFMT="%*Es total, %U user, %S system, %P cpu"
export VISUAL=vim

if [ -f $HOME/.zshrc_local ]; then
  source $HOME/.zshrc_local
fi
