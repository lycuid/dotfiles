new() {
  local repo=$(cut -d\/ -f1 <<< "$1")
  cd "$SCM/$repo" || return 1
  tmux -2 new-session -s "$repo" -n "code" \
    ';' new-window -d -n "shell" \
    ';' send-keys "clear && $EDITOR ." enter
  cd - &>/dev/null
}

open() {
  ls -Al "$SCM" \
    | egrep '^d' \
    | awk '{print $NF}' \
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
