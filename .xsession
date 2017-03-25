#!/bin/sh
: > ~/.xsession-errors
: > ~/.i3/log
xset s off
xset dpms 0 0 0
xset -dpms
xset s noblank
fbsetbg -l &
xmodmap ~/.Xmodmap &
xbindkeys
/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1 &
dbus-launch wicd-gtk -t &
diodon &
#remmina -i &
syndaemon -d -i3 -t -R
volti &
chrome &
# ssh-add &
exec ck-launch-session dbus-launch i3 > ~/.i3/log
