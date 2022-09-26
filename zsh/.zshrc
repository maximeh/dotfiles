autoload -Uz compinit
compinit
autoload -U edit-command-line
autoload -U zmv
zle -N edit-command-line

zstyle ':completion:*:(rsync|ssh|scp):*' hosts
zstyle ':completion:*:(rsync|ssh|scp):*' users
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

bindkey -v
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
bindkey '^xe' edit-command-line
bindkey '^x^e' edit-command-line

setopt vi
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
alias la='ls -AF'
alias ll='ls -lFh'
alias grep='grep --color=auto'
alias pswchan='ps xaopid,wchan:42,cmd'
alias ping='ping -c 5'
alias myip='curl https://m14n.dev/ip'
alias history='fc -il 1'
alias df='df -h'
alias du='du -h -c'
alias mmv='noglob zmv -W'
unalias vi 2>/dev/null
alias vi='vim'
alias duh="du "${@--xd1}" -h | sort -h"
alias open_port="lsof -Pn -i4tcp -stcp:listen"
alias g='git'

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
epoch() { date -d @$1; }
digga() { dig +nocmd "$1" any +multiline +noall +answer }
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

delete-branches() {
  git branch |
    grep --invert-match '\*' |
    cut -c 3- |
    fzf --multi --preview="git log {} --" |
    xargs --no-run-if-empty git branch --delete --force
}

# show username@host if logged in through SSH
if [[ $SSH_CLIENT != '' || $SSH_TTY != '' ]]; then
  local username='%n@%m '
fi
precmd() {
  print -P "%F{yellow}$username%f%F{blue}%~%F{8}%f"
}
PROMPT="%(!.%F{red}.%F{magenta})❯%f "

[[ $ZSH_EVAL_CONTEXT =~ :file$ ]] && sourced=1 || sourced=0
if [ $sourced -eq 1 ]; then
    PATH="/usr/sbin:/usr/bin/:/sbin:/bin"
fi

export DIRSTACKSIZE=5
export EDITOR=vim
export HISTFILE=~/.histfile
export HISTFILESIZE=$HISTSIZE
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help:* -h"
export HISTSIZE=50000
export KEYTIMEOUT=1
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LOCALE="en_US.UTF-8"
export PATH="/usr/local/opt/python@3.8/bin:$PATH"
export PATH=$PATH:$HOME/.bin:$HOME/.local/bin:$HOME/.$(uname -n)_bin:/opt/homebrew/bin:/opt/homebrew/sbin
export REPORTTIME=5
export SAVEHIST=10000
export TIMEFMT="%*Es total, %U user, %S system, %P cpu"
export VISUAL=vim

if [ -f $HOME/.$(uname -n) ]; then
   source $HOME/.$(uname -n)
fi
