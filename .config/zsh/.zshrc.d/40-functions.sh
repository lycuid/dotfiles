take() {
  mkdir -p $1 && cd $1
}

# start new tmux session with a specific arrangement.
new() {
  [ "$#" -ne 1 ] && echo "Invalid commandline arguments." && return 1

  local repo=$(cut -d\/ -f1 <<< "$1")
  cd "$SCM/$repo" 2>/dev/null
  cded=$?

  tmux -2 new-session -d -s "$repo" -n "code" ';' new-window -d -n "shell" \
    || { cd - &>/dev/null && return 1 }
  if [ $cded -eq 0 ]; then
    tmux select-window -t "${repo}:code" \
      ';' send-keys "clear && $EDITOR ." enter
    cd - &>/dev/null
  fi
  tmux attach-session -t "$repo"
}

# choose and open a directory from '$SCM' directory in '$EDITOR'.
open() {
  ls -Al "$SCM" \
    | awk '/^d/ {print $NF}' \
    | fzf \
    | xargs -i $EDITOR +"cd $SCM/{}" "$SCM/{}"
}
bindkey -s '^o' "open\n"

# choose and open any of the version controlled dotfiles.
conf() {
  VC_DOTFILES="$SCM"/dotfiles
  git -C "$VC_DOTFILES" ls-files --recurse-submodules \
    | fzf \
    | xargs -i $EDITOR "$VC_DOTFILES"/{}
}
bindkey -s '^p' "conf\n"

# choose and open any active tmux session.
sessions() {
  session_name=$(tmux ls -F "#{session_name}" | fzf)
  [ -n "$session_name" ] && tmux a -t "$session_name" || return 0;
}
bindkey -s '^t' "sessions\n"
