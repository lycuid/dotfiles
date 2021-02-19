launch_dwm() {
  while :;
  do
    DATE=$(date +'%a, %b %d %H:%M:%S')
    MEM=$(free | awk '/Mem/ {printf "%.f\n", (($3+$5)/$2)*100}')

    xsetroot -name " [mem: $MEM%] | $DATE"
    sleep 1
  done &

  exec dwm
}
