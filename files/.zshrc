# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export LC_ALL=en_US.UTF-8

ZSH_THEME_FILE=~/.oh-my-zsh/themes/simple-lambda.zsh-theme
if [[ ! -f "$ZSH_THEME_FILE" ]]; then
  THEME_FILE="https://raw.githubusercontent.com/lycuid/simple-lambda-zsh-theme/master/simple-lambda.zsh-theme"
  curl -o $ZSH_THEME_FILE $THEME_FILE 2> /dev/null
  unset THEME_FILE
fi
unset ZSH_THEME_FILE

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="simple-lambda"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"


# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# pscp -i ~/Desktop/private_key.ppk ~/Desktop/desertbox_sql/"finance queries"/#  coll_ticket_created.sql mis@52.77.139.211:/home/mis/sql_files/
#&& google-chrome 'http://52.77.139.211/cgi-bin/update_data.py?file_name="$2"&action=DATA-UPDATE'

if [[ -f ~/.profile ]] && [[ -o login ]]; then
  source ~/.profile
fi

