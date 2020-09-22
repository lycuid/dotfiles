#!/bin/sh

amixer get Master | awk '\
BEGIN {
  sound=0;\
  speaker=0;\
  mute="";\
}\
match($0, /[[:digit:]]+%/) {\
  sound+=substr($0, RSTART, RLENGTH - 1);\
  speakers+=1;\
  if ($6 == "[off]") {\
    mute="";\
  }\
}\
END {\
  if (speakers > 0) {\
    print mute, sound/speakers;\
  }\
}\
'
