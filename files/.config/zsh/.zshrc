export ZSH=~/.oh-my-zsh
export LC_ALL=en_US.UTF-8

# Download oh my zsh, if not exist
[ ! -d "$ZSH" ] && curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

ZSH_THEME_FILE=~/.oh-my-zsh/themes/simple-lambda.zsh-theme
if [ ! -f "$ZSH_THEME_FILE" ];
then
  THEME_FILE="https://raw.githubusercontent.com/lycuid/simple-lambda-zsh-theme/master/simple-lambda.zsh-theme"
  curl -o $ZSH_THEME_FILE $THEME_FILE 2> /dev/null
  unset THEME_FILE
fi
unset ZSH_THEME_FILE

ZSH_THEME="simple-lambda"
plugins=(git)

source $ZSH/oh-my-zsh.sh

alias rm="rm -riv"
alias server="python3 -m http.server"
alias mx="tmux"
alias ls="exa --git --icons"

