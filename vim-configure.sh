#!/bin/bash

# pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# installing required bundles
declare -A BUNDLES
BUNDLES=(
  ["https://github.com/vim-airline/vim-airline"]="vim-airline"
  ["https://github.com/scrooloose/nerdtree.git"]="nerdtree"
  ["https://github.com/kien/ctrlp.vim.git"]="ctrlp.vim"
  ["https://github.com/airblade/vim-gitgutter.git"]="vim-gitgutter"
  ["https://github.com/Shougo/neocomplete.vim.git"]="neocomplete.vim"
  ["https://github.com/plytophogy/vim-virtualenv.git"]="vim-virtualenv"
  ["https://github.com/jakwings/vim-colors.git"]="vim-colors"
  ["https://github.com/tpope/vim-fugitive.git"]="vim-fugitive"
)

for i in "${!BUNDLES[@]}";
do
  DIRECTORY=~/.vim/bundle/${BUNDLES[$i]}
  if [[ ! -d "$DIRECTORY" ]]; then
    git clone "$i" "$DIRECTORY"
    echo -e "[\e[32m+\e[39m] \e[32m$DIRECTORY Installed.\e[39m"
  else
    echo -e "[\e[33m!\e[39m] \e[33m$DIRECTORY Already Exists\e[39m"
  fi
done

# powerline fonts (doesn't need pathogen)
git clone https://github.com/powerline/fonts.git --depth=1 ~/powerline-fonts
~/powerline-fonts/install.sh
rm -rf ~/powerline-fonts


echo -e "[\e[32m+\e[39m] \e[32mCompleted\e[39m"
