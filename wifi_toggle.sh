#!/bin/sh
## This script toggles the Wifi adapter(s).
## Works on Ubuntu 16.04lts and up.
STATEFILE="/tmp/wifitoggle.state"
 
if [ $# -eq 1 ]; then
  case $1 in
    "up"|"on")
      STATE=off
      ;;
    "down"|"off")
      STATE=on
      ;;
  esac
else
  if [ ! -e ${STATEFILE} ]; then
    STATE=on
  else
    . ${STATEFILE}
  fi
fi
if [ -z ${STATE} ]; then
  STATE=on
fi
 
if [ ${STATE} = "on" ]; then
  nmcli radio wifi off
  STATE=off
  echo 'Wifi off'
  notify-send 'Wifi off'
  ## uncomment for optional sound cue
  #play -q ~/Púublic/wifioff.ogg -t alsa & #
#  disown #
else
  nmcli radio wifi on
  STATE=on
  echo 'Wifi on'
  notify-send 'Wifi on'
  ##Uncomment for optional sound cue
  #play -q ~/Public/wifion.ogg -t alsa & #
  #  disown #
fi
 
echo "STATE=${STATE}" > ${STATEFILE}
