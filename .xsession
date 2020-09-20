#!/bin/sh
# Xsession doesn't set these vars properly.
export PATH="/home/han/.bin:/usr/local/sbin:/usr/local/bin:/sbin:/usr/sbin:/bin:/usr/bin:/usr/games:/mp3/bin"
export TMP="$HOME/.local/tmp"
export TMPDIR="$TMP"
export XDG_RUNTIME_DIR=/run/user/$(id -u)
export XDG_CURRENT_DESKTOP=i3
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
export TZ='Europe/Vienna'

: > ~/.xsession-errors
xset s off
xset dpms 0 0 0
xset -dpms
xset s noblank
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources
fbsetbg -l &
# Check settings with: setxkbmap -print -verbose 10
setxkbmap -model pc105 -layout us -option compose:rctrl -option caps:none
nm-applet &
redshift-gtk -l 46.8471:15.5206 &
diodon &
syndaemon -d -i3 -t -R
# blueman-applet &
xss-lock -l -n /home/han/.bin/dim -- /home/han/.bin/lockmeup &
picom &
(
    # WHYYYYY!!!!?!?!!?!?!?!
    systemctl --user disable pulseaudio.socket ; systemctl --user disable pulseaudio.service
    systemctl --user stop pulseaudio.socket ;systemctl --user stop pulseaudio.service
    qjackctl -a ~/.config/rncbc.org/patchbay.xml -s &
    dunst &
    sleep 6
    flameshot &
    sleep 6
) &

exec dbus-run-session /usr/bin/i3 > ~/.local/log/i3.log
