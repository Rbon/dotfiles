#! /usr/bin/env bash

### WARNING: BEFORE RUNNING THIS, BACK UP ANY DOTFILES YOU DON'T WANT TO LOSE

dotfiles=".aliases .dir_colors .vimrc .tmux.conf .zshrc"

script_location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd $HOME

function link_files {
  for dotfile in $dotfiles; do
    echo "Making link for: ${dotfile}"
    ln -sf "${script_location}/${dotfile}"
  done
}

function install_vundle {
  echo "Installing Vundle..."
  git clone --quiet \
    https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  echo "Done."
}

link_files
install_vundle
