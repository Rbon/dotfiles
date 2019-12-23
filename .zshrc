# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_IGNORE_ALL_DUPS
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/robin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
stty -ixon
# PROMPT="%n@%m \$ "

## VI Mode stuff ##
precmd() { RPROMPT="" }
function zle-line-init zle-keymap-select {
  VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"
  RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
  zle reset-prompt
}

## remember mode through returns
accept-line() { prev_mode=$KEYMAP; zle .accept-line }
zle-line-init() { zle -K ${prev_mode:-viins} }

zle -N zle-line-init
zle -N zle-keymap-select
zle -N accept-line
## End of VI Mode stuff ##

## Prompt stuff
autoload -Uz promptinit
promptinit
prompt redhat

export PATH="$PATH:$HOME/.scripts"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export VK_ICD_FILENAMES="/usr/share/vulkan/icd.d/radeon_icd.x86_64.json"
export KEYTIMEOUT=1 # decrese lag when switching to normal mode
# export TERM=rxvt-unicode-256color
bindkey -v '^?' backward-delete-char
eval `dircolors ~/.dir_colors`

[ -f ~/.aliases  ] && source ~/.aliases
[ -f ~/.privaterc  ] && source ~/.privaterc
[ -f  /etc/profile.d/autojump.zsh ] && source /etc/profile.d/autojump.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

## Powerline stuff
#if [[ -r /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
#    source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
#fi
