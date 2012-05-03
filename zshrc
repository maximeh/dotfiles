# /etc/zsh/zshrc ou ~/.zshrc
# Fichier de configuration principal de zsh

autoload -Uz compinit 
compinit 

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# use cache zsh
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache
zmodload zsh/complist
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

uname_str=`uname`

LS_COLORS='no=00;32:fi=00:di=00;34:ln=01;36:pi=04;33:so=01;35:bd=33;04:cd=33;04:or=31;01:ex=00;32:*.rtf=00;33:*.txt=00;33:*.html=00;33:*.doc=00;33:*.pdf=00;33:*.ps=00;33:*.sit=00;31:*.hqx=00;31:*.bin=00;31:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.deb=00;31:*.dmg=00;36:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.ppm=00;35:*.tga=00;35:*.xbm=00;35:*.xpm=00;35:*.tif=00;35:*.mpg=00;37:*.avi=00;37:*.gl=00;37:*.dl=00;37:*.mov=00;37:*.mp3=00;35:'
export LS_COLORS;

################
# 1. Les alias #
################
co() { echo "$*" | bc -l; } #define the co function to calculate
type() { echo "$*" | pv -qL 10; } #Simulate type char by char

case $uname_str in
    Linux)
        # Linux Specific
        export LS_COLORS=$LS_COLORS"di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=32;38:tw=0;42:ow=0;43:"
        alias ls="ls -F --color"       # Color is handled differently on Linux
        ;;
    Darwin)
        # Mac Specific
        alias ls='ls -GFp'          # Compact view, show colors
        ;;
    *)
        ;;
esac

# Filesystem
alias ..='cd ..' # Go up one directory
alias ...='cd ../..' # Go up two directories
alias ....='cd ../../..' # And for good measure
alias l='ls -lah' # Long view, show hidden
alias la='ls -AF' # Compact view, show hidden
alias ll='ls -lFh' # Long view, no hidden

# Helpers
alias grep='grep --color=auto' # Always highlight grep search term
alias psg='ps aux | grep -v grep | grep $1'   # See what's running
alias ping='ping -c 5' # Pings with 5 packets, not unlimited
alias history='fc -l 1' # I want to see more the 16 history items
alias df='df -h' # Disk free, in gigabytes, not bytes
alias du='du -h -c' # Calculate total disk usage for a folder
unalias vi 2>/dev/null
alias vi='vim -p'
unalias vim 2>/dev/null
alias vim='vim -p'
alias rec='ffmpeg -f x11grab -r 25 -s 800x600 -i :0.0' # record desk to a file
alias intercept='strace -ff -e trace=write -e write=1,2 -p' # intercept stdout,stderr of PID
alias duh="du "${@--xd1}" -h | sort -h" # sort dir in . based on their size
alias firefox="nohup /opt/firefox/firefox > /dev/null 2>&1 &"
alias thunderbird="nohup /opt/thunderbird/thunderbird > /dev/null 2>&1 &; disown %1"
alias songbird="nohup /opt/Songbird/songbird > /dev/null 2>&1 &; disown %1"
alias sublime="nohup /opt/Sublime\ Text\ 2/sublime_text > /dev/null 2>&1 &; disown %1"


alias gen_pwd="cat /dev/urandom|tr -dc "a-zA-Z0-9-_\$\?\@\!\="|fold -w 8|head -n 10" #Generate password
# fix_stty: restore terminal settings when they get completely screwed up
alias fix_stty='stty sane'
# ff:  to find a file under the current directory
ff () { find . -name "$@" ; }
# # ffs: to find a file whose name starts with a given string
ffs () { find . -name "$@"'*' ; }
# # ffe: to find a file whose name ends with a given string
ffe () { find . -name '*'"$@" ; }

# enquote: surround lines with quotes (useful in pipes) - from mervTormel
enquote () { sed 's/^/"/;s/$/"/' ; }

# Network
#
# osock: to display open sockets (the -P option to lsof disables port names)
alias osock='sudo lsof -i -P'
# http_headers: get just the HTTP headers from a web page (and its redirects)
http_headers () { curl -I -L $@ ; }

# Git alias
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gc='git commit'
alias gs='git status -sb'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"

#######################################
# 2. Prompt et définition des touches #
#######################################

## Keybindings and Prompt
# Lookup in /etc/termcap or /etc/terminfo else, you can get the right keycode
# by typing ^v and then type the key or key combination you want to use.
# "man zshzle" for the list of available actions

# Correspondance touches-fonction
bindkey -v

bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
#for guake
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\eOF" end-of-line
bindkey "\eOH" beginning-of-line

bindkey "\e[3~" delete-char
bindkey '^?' backward-delete-char
bindkey '^R' history-incremental-search-backward

# Gestion de la couleur
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

# Prompt couleur (la couleur n'est pas la meme pour le root et
# pour les simples utilisateurs)

local name="%{$FX[reset]$FG[205]%}%n%{$FX[reset]%}"
local name_bold="%{$FX[bold]$FG[205]%}%n%{$FX[reset]%}"

local name_root="%{$FX[reset]$FG[001]%}%n%{$FX[reset]%}"
local name_root_bold="%{$FX[bold]$FG[001]%}%n%{$FX[reset]%}"

local host="%{$FX[reset]$FG[208]%}%m%{$FX[reset]%}"
local host_bold="%{$FX[bold]$FG[208]%}%m%{$FX[reset]%}"

local dir="%{$FX[reset]$FG[012]%}%2c%{$FX[reset]%}"
local dir_bold="%{$FX[bold]$FG[012]%}%2c%{$FX[reset]%}"

case "$TERM" in 
 screen-*) 
    if [ "`id -u`" -eq 0 ]; then
       PS1="┌─${name_root_bold} at ${host_bold} in ${dir_bold}
└─╼ "
    else
        PS1="┌─${name_bold} at ${host_bold} in ${dir_bold}
└─╼ "
    fi
 ;; 
 *) 
    if [ "`id -u`" -eq 0 ]; then
       PS1="┌─${name_root} at ${host} in ${dir}
└─╼ "
    else
       PS1="┌─${name} at ${host} in ${dir}
└─╼ "
    fi
 ;; 
esac 
RPS1="(%D{%m-%d %H:%M})%{$FX[reset]%}" 

# Titre de la fenêtre d'un xterm
case $TERM in
   xterm*)
     precmd () {print -Pn "\e]0;%n@%m: %~\a"}
   ;;
esac

###########################################
# 3. Options de zsh (cf 'man zshoptions') #
###########################################

# Options de complétion
# Quand le dernier caractère d'une complétion est '/' et que l'on
# tape 'espace' après, le '/' est effaçé
setopt auto_remove_slash
# Fait la complétion sur les fichiers et répertoires cachés
setopt glob_dots

# if `rm *` wait 10 seconds before performing it!
setopt rmstarwait

# Traite les liens symboliques comme il faut
setopt chase_links

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt autocd
setopt autopushd pushdminus pushdsilent pushdtohome
setopt cdablevars

# Try to correct command line spelling
setopt correct correct_all

# Enable extended globbing
setopt extended_glob

unsetopt list_ambiguous
unsetopt beep 
unsetopt hist_beep 
unsetopt list_beep 

###############################################
# 4. Paramètres de l'historique des commandes #
###############################################

# Nombre d'entrées dans l'historique
HISTSIZE=1000
SAVEHIST=1000

# Fichier où est stocké l'historique
HISTFILE=~/.histfile

#ajoute l'historique à la fin de l'ancien fichier
setopt append_history

# Ne stocke pas  une ligne dans l'historique si elle  est identique à la
# précèdente
setopt hist_ignore_dups

###############################################
# 5. Exports                                  #
###############################################

# Show time a command took if over 2 sec
# https://github.com/bjeanes/dot-files/commit/1ae5bc72dac6d5f2cdfbf5a48fdf140c5d085986
export REPORTTIME=2
export TIMEFMT="%*Es total, %U user, %S system, %P cpu"

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export EDITOR="/usr/bin/vim"
export LOCALE="en_US.UTF-8"

export VISUAL=vim
export EDITOR=vim
export PATH=$PATH:$HOME/bin:/usr/sbin:/sbin



export PERL_LOCAL_LIB_ROOT="/home/maxime/perl5";
export PERL_MB_OPT="--install_base /home/maxime/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/maxime/perl5";
export PERL5LIB="/home/maxime/perl5/lib/perl5/i486-linux-gnu-thread-multi-64int:/home/maxime/perl5/lib/perl5";
export PATH="/home/maxime/perl5/bin:$PATH";
