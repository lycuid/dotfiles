vcd() {
  cd $(vifm --choose-dir - ~)
}
bindkey -s '^o' "vcd\n"

