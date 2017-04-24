# Always load this file first.

# This function helps checking features against versions.
autoload -U is-at-least

# Too bad I have to put this function over here.
cleanpath()
{
    print "$^@"(N)
}

# Pathes
path=(
    ~/.bin
    /usr/local/{s,}bin
    /opt/{s,}bin
    /usr/{s,}bin
    /{s,}bin
    /usr/games
    /usr/X11R6/bin
    /usr/syno/{s,}bin/
)

manpath=(
    /usr/man
    /usr/share/man
    /usr/local/man
    /usr/local/share/man
)

path=($(cleanpath $path))
manpath=($(cleanpath $manpath))

export path manpath

if [[ -w ~ ]]; then
    export TMP=~/.tmp
    export TMPDIR=$TMP
    mkdir -p -m700 $TMP/emacs$UID
    mkdir -p -m700 ~/.ssh
    chmod -R go-rwx $TMP ~/.ssh
fi

local HOST=$(LC_ALL=C uname -n)
# export NULLCMD=:
export PERL_BADLANG=0
unset  LC_ALL
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LC_ALL

# Only set this variable if running in X
[ "$XAUTHORITY" ] && export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

unset WORDCHARS

# Don't wanna know I got new mail :P
unset mailpath MAILCHECK
