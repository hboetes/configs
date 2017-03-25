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

export TMP=~/.tmp
export TMPDIR=$TMP
[[ ! -d $TMP ]] && mkdir -m700 $TMP
[[ ! -d $TMP/emacs$UID ]] && mkdir -m700 $TMP/emacs$UID
[[ ! -d ~/.ssh ]] && mkdir -m700 ~/.ssh
chmod go-rwx $TMP $TMP/emacs$UID ~/.ssh

local HOST=$(LC_ALL=C uname -n)
# export NULLCMD=:
export PERL_BADLANG=0
unset  LC_ALL
export LANG=en_US.UTF-8
export LC_COLLATE=C
export LC_ALL

[[ -x /usr/local/bin/gdircolors ]] && alias dircolors='/usr/local/bin/gdircolors'

# If we use a terminal capable of 256 colors
if [[ $TERM = *256color ]]; then
    eval $(dircolors -b $ZDOTDIR/LS_COLORS)
else
    export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;00:cd=40;33;00:or=40;31;00:ex=00;32:*.tar=00;31:*.tgz=00;31:*.rar=00;31:*.ace=00;31:*.zip=00;31:*.bz2=00;31:*.rpm=00;31:*.gz=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.png=00;35:*.tga=00;35:*.xpm=00;35:*.mpg=00;37:*.avi=00;37:*.mp4=00;37:*.mkv=00;37:*.mov=00;37:*.mp3=01;35:*.flac=01;35:*.ogg=01;35:*.mpc=01;35:*.wav=01;35:*.ape=01;35:*.core=00;33:*~=01;30'
fi

# export RSYNC_RSH=ssh
# export CVS_RSH=ssh
# Only set this variable if running in X
[ "$XAUTHORITY" ] && export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

unset WORDCHARS

# Don't wanna know I got new mail :P
unset mailpath MAILCHECK
