take() {
  mkdir -p $1 && cd $1
}

new() {
  [ "$#" -ne 1 ] && echo "Invalid commandline arguments." && return 1

  local repo=$(cut -d\/ -f1 <<< "$1")
  cd "$SCM/$repo" 2>/dev/null
  cded=$?

  tmux -2 new-session -d -s "$repo" -n "code" ';' new-window -d -n "shell" || { cd - &>/dev/null && return 1 }
  if [ $cded -eq 0 ]; then
    tmux select-window -t "${repo}:code" ';' send-keys "clear && $EDITOR ." enter
    cd - &>/dev/null
  fi
  tmux attach-session -t "$repo"
}

open() {
  ls -Al "$SCM" \
    | awk '/^d/ {print $NF}' \
    | fzf \
    | xargs -i $EDITOR +"cd $SCM/{}" "$SCM/{}"
}
bindkey -s '^o' "open\n"

conf() {
  find "$SCM"/dotfiles/.* -type f -not -regex ".*\.git\/?.*" \
    | sed -rn 's/.*dotfiles\/(.*)$/\1/p' \
    | fzf \
    | xargs -i $EDITOR "$SCM"/dotfiles/{}
}
bindkey -s '^p' "conf\n"
