#!/bin/bash
battery0=''
battery25=''
battery50=''
battery75=''
battery100=''

acConnectionIcon=' ﮣ '

batteryCharge=`pmset -g batt | tail -n -1 | awk '{printf "%d", $3}'`
powerWattage=`pmset -g ac | head -n 1 | awk '{printf "%d", $3}'`
icon=battery0

if (( batteryCharge > 75 )); then
  icon=$battery100
elif (( batteryCharge > 50 )); then
  icon=$battery75
elif (( batteryCharge > 25 )); then
  icon=$battery50
elif (( batteryCharge > 5 )); then
  icon=$battery25
else
  icon=$battery0
fi

printf "$icon  $batteryCharge%%%s%s%s\n" $( [ $powerWattage -gt 0 ] && echo "$acConnectionIcon $powerWattage W")
