## If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

## append to the history file, don't overwrite it
shopt -s histappend

## for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

## check the window size after each command and, if necessary,
## update the values of LINES and COLUMNS.
shopt -s checkwinsize

## set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

## If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

## enable programmable completion features (you don't need to enable
## this, if it's already enabled in /etc/bash.bashrc and /etc/profile
## sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# export TERM=xterm-256color
export QUOTING_STYLE=literal


## Stop ranger from loading both the default and custom rc file.
RANGER_LOAD_DEFAULT_RC=FALSE

export VISUAL="vim"

## aliases
alias ls="ls -AX --color=auto --group-directories-first"
# alias tmux="tmux source-file ~/.config/tmux.conf"
alias install="sudo pacman -S"
alias remove="sudo pacman -R"
# alias install="sudo apt-get install"
alias grep='grep --color=auto'
alias subl3="subl3 -n"
alias fix-pacman="sudo pacman -Syy"
alias starwars="telnet towel.blinkenlights.nl"

## functions
cl() { cd "$@" && ls; }
nusync-misc() { rsync -avs "rbon@nu.jercos.moe:/home/rbon/www/misc/$@" .; }
vbr-encode() { 
for ext in .flac .ape; do
  for f in *$ext; do
    ffmpeg -i "$f" -qscale:a 0 "$(basename "$f" "$ext").mp3"
  done
done; }

## include .bash_private if it exists
if [[ -f $HOME/.bash_private ]]; then
    . $HOME/.bash_private
fi
  
