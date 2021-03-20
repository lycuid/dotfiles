# vim: ft=sh

DWN_CACHE_DIR=${XDG_CACHE_HOME:-$HOME/.cache}/dwm

# constants.
batsym=(               )
batsymlen=${#batsym[@]}

NETWORK() {
  ACTIVE_INTERFACE=$(ip link | grep "state UP" | head -n1 | cut -d\  -f2)
  [ -z "$ACTIVE_INTERFACE" ] && return 0

  prev_bytes="$DWN_CACHE_DIR"/network_bytes
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
  prev_data="$DWN_CACHE_DIR"/cpu_data
  [ ! -f "$prev_data" ] && echo "0 0 0 0 0 0 0" > "$prev_data"

  read puser pnice psystem pidle piowait pirq psoftirq < "$prev_data"
  read user nnice system idle iowait irq softirq <<< $(head -n1 /proc/stat | cut -d\  -f3-9)

  newtotal=$(( user + nnice + system + idle + iowait + irq + softirq ))
  prevtotal=$(( puser + pnice + psystem + pidle + piowait + pirq + psoftirq ))
  total=$(( newtotal - prevtotal ))

  used=$(( (user + nnice + system) - (puser + pnice + psystem) ))
  echo "$user $nnice $system $idle $iowait $irq $softirq" > "$prev_data"

  printf "  %3s%%" $(( 100 * used / total ))
}

MEM() {
  free | awk '
    /Mem/ { c = ($3 + $5) / 1024 }
    END   {
      if (c >= 1000) {
        printf "  %.2f GiB", c/1024
      } else {
        printf "  %4d MiB", c
      }
    }'
}

BAT() {
  batindexfile="$DWN_CACHE_DIR"/bat_symbol
  [ ! -f "$batindexfile" ] && echo "0" > "$batindexfile"

  read batindex < "$batindexfile"
  echo $(( (batindex + 1) % batsymlen)) > "$batindexfile"

  for BAT_DIR in /sys/class/power_supply/BAT*;
  do
    batcapacity=$(<"$BAT_DIR"/capacity)
    case $(<"$BAT_DIR"/status) in
      Charging)     batstatus="${batsym[$batindex]}  ";;
      Discharging)  batstatus="${batsym[$(( batcapacity * batsymlen / 100 ))]}  ";;
      Full)         batstatus="${batsym[$(( batsymlen - 1))]}  ";;
      *)            batstatus="   "
    esac
    echo "$batstatus $batcapacity%  |  "
  done
}

DATE() {
  echo "$(date +'%a, %b %d %H:%M:%S')"
}

mkdir -p "$DWN_CACHE_DIR"

while true
do
  xsetroot -name "  $(NETWORK)  |  $(CPU)  |  $(MEM)  |  $(BAT)$(DATE)"
  sleep 1
done &

exec dwm
