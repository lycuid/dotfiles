NETWORK() {
  ACTIVE_INTERFACE=$(ip link | grep "state UP" | head -n1 | cut -d\  -f2)
  [ -z "$ACTIVE_INTERFACE" ] && return 0

  prev_bytes=${XDG_CACHE_HOME:-$HOME/.cache}/dwm/network_bytes
  [ ! -f "$prev_bytes" ] && echo "0 0" > "$prev_bytes"

  read prx ptx < $prev_bytes
  read RX TX <<< $(
    rx_bytes=0
    tx_bytes=0

    for NETDIR in /sys/class/net/*;
    do
      rx_bytes=$(( rx_bytes + "$(<"$NETDIR"/statistics/rx_bytes)" ))
      tx_bytes=$(( tx_bytes + "$(<"$NETDIR"/statistics/tx_bytes)" ))
    done

    echo "$rx_bytes $tx_bytes"
  )
  echo "$RX $TX" > "$prev_bytes"

  echo "$ACTIVE_INTERFACE  $(( (RX-prx) / 1024 )) KiB/s  $(( (TX-ptx) / 1024 )) KiB/s"
}

CPU() {
  prev_data=${XDG_CACHE_HOME:-$HOME/.cache}/dwm/cpu_data
  [ ! -f "$prev_data" ] && echo "0 0 0 0 0 0 0" > "$prev_data"

  read puser pnice psystem pidle piowait pirq psoftirq < "$prev_data"
  read user nnice system idle iowait irq softirq <<< $(head -n1 /proc/stat | cut -d\  -f3-9)

  newtotal=$(( user + nnice + system + idle + iowait + irq + softirq ))
  prevtotal=$(( puser + pnice + psystem + pidle + piowait + pirq + psoftirq ))
  total=$(( newtotal - prevtotal ))

  used=$(( (user + nnice + system) - (puser + pnice + psystem) ))
  echo "$user $nnice $system $idle $iowait $irq $softirq" > "$prev_data"

  echo "$(( 100 * used / total ))%"
}

MEM() {
  echo $(free | awk '
    /Mem/ { c = ($3 + $5) / 1024 }
    END   {
      if (c >= 1024) {
        printf "%.2f GiB\n", c/1024
      } else {
        printf "%.f MiB\n", c
      }
    }')
}

DATE() {
  echo "$(date +'%a, %b %d %H:%M:%S')"
}

launch_dwm() {
  while true
  do
    xsetroot -name " $(NETWORK)  [cpu: $(CPU)]  [mem: $(MEM)]  $(DATE)"
    sleep 1
  done &

  exec dwm
}

mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/dwm

