#!/bin/sh
export PATH="/home/han/.bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/games:/mp3/bin"
: > ~/.xsession-errors
xset s off
xset dpms 0 0 0
xset -dpms
xset s noblank
fbsetbg -l &
setxkbmap -option caps:none
egrep -v '^(!|$)' .Xmodmap | while read line; do xmodmap -e "$line"; done
dbus-launch wicd-gtk -t &
redshift-gtk -l 46.8471:15.5206 &
diodon &
syndaemon -d -i3 -t -R
flameshot &
exec dbus-launch i3 > ~/.local/log/i3.log
