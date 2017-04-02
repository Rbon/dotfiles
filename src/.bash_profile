#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc


export PATH="${PATH}:/home/robin/.scripts"
export PATH="/home/robin/.gem/ruby/2.4.0/bin:$PATH"
export PATH=$PATH:$(go env GOPATH)/bin
