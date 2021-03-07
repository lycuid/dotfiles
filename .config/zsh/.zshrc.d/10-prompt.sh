autoload -U colors && colors

setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%b'
zstyle ':vcs_info:*' enable git

git_branch() {
  local LAMBDA="%(?,%{$fg_bold[green]%}λ,%{$fg_bold[red]%}λ)%{$reset_color%}"
  vcs_info
  [ -n "$vcs_info_msg_0_" ] && \
    echo " %{$reset_color%}(%{$fg_bold[blue]%}${vcs_info_msg_0_}%{$reset_color%})\n$LAMBDA" || \
    echo " $LAMBDA"
}
USER="%(!.%{$fg[red]%}%n%{$reset_color%}.%{$fg[cyan]%}%n%{$reset_color%})"
PS1=$'\n'"%{$fg[red]%}[$USER%B%{$fg[blue]%}@%b%{$fg[white]%}%m %{$fg[magenta]%}\
%1~%{$reset_color%}%{$fg[red]%}]"$'$(git_branch)'"%{$reset_color%} "

