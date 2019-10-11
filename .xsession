#!/bin/sh
export PATH="/home/han/.bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/games:/mp3/bin"
export TMP="$HOME/.local/tmp"
export TMPDIR="$TMP"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

pkill pulse

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
# blueman-applet &
compton &
dunst &
(
    qjackctl -a ~/.config/rncbc.org/patchbay.xml -s &
    sleep 6
    pulseaudio -L module-jack-sink -D
    flameshot &
) &

exec dbus-run-session /usr/local/bin/i3 > ~/.local/log/i3.log
