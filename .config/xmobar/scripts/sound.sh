#!/bin/sh

SINKS=$(pactl list sinks)
MUTE=$(echo "$SINKS" | grep Mute | awk '{print $2}')

echo "$SINKS" \
  | egrep "^\s+Volume" \
  | sed -nr "s/.*\s([0-9]+)\%.*,.*\s([0-9]+)\%.*/\1 \2/p" \
  | xargs -i echo "{} $MUTE" \
  | awk '/yes/ {mute=" "} /no/ {mute=" "} END {print mute,($1 + $2) / 2}'

