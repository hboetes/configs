alias zzz='sync; sudo s2ram'
alias dark='xset dpms force suspend'
alias enqueue='ls $PWD/* >> /mp3/queue'

alias split="shnsplit -o flac -f *cue -t '%p - %a - %n - %t' *flac"

# alias penguinradio='mplayer -really-quiet http://81.173.3.20/listen.pls'
# alias fro_radio='mplayer -really-quiet http://www.fro.at:8008/fro-128.ogg'

# alias ldapvi='ldapvi --discover -D cn=manager,dc=axis-simulations,dc=at -h ldap://auth'



xcontest()
{
    gpsbabel -i garmin_fit -o igc -f $1 -F ~/flight.igc
}

convertflight()
{
    if [[ -z $1 ]]; then
        echo "Gimme a filename?!" >&2
        return 1
    fi
    if [[ ! -f $1 ]]; then
        echo "Where is that file?!" >&2
        return 1
    fi
    if ! file $1|\grep -q  'FIT.*Map.*data.*serial.*manufacturer.*garmin.*product.*type' ;then
        echo "That's not a garmin file?!" >&2
        return 1
    fi
    # gpsbabel -i garmin_fit -o igc -f $1 -F ${1%.fit}.igc
    gpsbabel -i garmin_fit -o gpx -f $1 -F ${1%.fit}.gpx
}

export DEBMAIL="Han Boetes <han@boetes.org>"

tsync()
{
    rsync -avP ~/torrents/*.torrent difool:downloads/.torrents/ &&
    rm ~/torrents/*.torrent
}

mpv()
{
    if [ -L /dev/snd/by-id/usb-Logitech_Logitech_G933_Gaming_Wireless_Headset-00 ]; then
        device="alsa/dmix:CARD=H,DEV=0"
    elif [ -L /dev/snd/by-id/usb-Creative_Technology_USB_Sound_Blaster_HD_000000te-00 ]; then
        device="alsa/dmix:CARD=HD,DEV=0"
    else
        device="auto"
    fi
    # mpv --audio-device $device -vo null -af volume=-10:replaygain-album,equalizer=0:0:0:0:0:0:0:0:0:0 --msg-level all=no,statusline=v "$@"
    /usr/bin/mpv --audio-device $device "$@"
}

alias ksync='rsync --rsync-path=/opt/bin/rsync'
alias wsync='\rsync -azv --no-perms --no-times --size-only'
