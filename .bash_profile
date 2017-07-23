#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


export PATH="${PATH}:/home/robin/.scripts"
export PATH=$PATH:$(go env GOPATH)/bin
