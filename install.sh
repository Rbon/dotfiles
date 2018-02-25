### WARNING: BEFORE RUNNING THIS, BACK UP ANY DOTFILES YOU DON'T WANT TO LOSE

dotfiles=".aliases .dir_colors .vimrc .tmux.conf .zshrc"

script_location="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${HOME}/temp"

function link_files {
  for dotfile in $dotfiles; do
    ln -sf "${script_location}/${dotfile}"
  done
}

link_files
