launch_dwm() {
  while true
  do
    DATE=$(date +'%a, %b %d %H:%M:%S')
    MEM=$(free | awk '/Mem/ {printf "%.2fG\n", ($3+$5)/(1024*1024)}')

    xsetroot -name " [mem: $MEM] | $DATE"
    sleep 1
  done &

  exec dwm
}
