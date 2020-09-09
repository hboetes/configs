# Below are the color init strings for the basic file types. A
# color init string consists of one or more of the following
# numeric codes:
#
# Attribute codes:
# 00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
# 30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
# 40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

name2color()
{
    local color
    if whence -v printf | \grep builtin > /dev/null; then
        sum=0
        len=${#1}
        striph=$(print $1|tr -cd '[[:alnum:]]')
        for i in {1..$len}; do
            char="${striph[$i]}"
            num="$((#char))"
            ((sum += num))
        done
    else
        sum=$RANDOM
    fi
    if [[ $TERM == *-256color ]]; then
        ((color = sum % 256))
        sed -i "s|set-option -g status-fg .*|set-option -g status-fg colour$color|" ~/.tmux.local
        color="38;5;$color"
    else
        ((color = sum % 7 + 31))
    fi
    echo "%{\e[${color}m%}$1%{\e[00m%}"
}

autoload -U colors
colors

local HOSTNAME=$(hostname -s)
local USERHOST="${USER}@${HOSTNAME}"

# Old zsh releases don't dig a fancy prompt.
if [[ ${ZSH_VERSION%%.*} -lt 4 ]]; then
    local prompt="$USERHOST%~%# "
    return
fi

local usercolor=$(name2color $USER)
local hostcolor=$(name2color $HOSTNAME)
unfunction name2color

prompt="$usercolor@$hostcolor %~ %(!|%{$fg[yellow]%}|%{$fg_bold[black]%})%(?..%{$fg[red]%})%#%{$fg_no_bold[default]%} "
