# Always load this file first.

# This function helps checking features against versions.
autoload -U is-at-least

# Too bad I have to put this function over here.
cleanpath()
{
    print "$^@"(N)
}

# Paths
path=(
    ~/.local/bin
    ~/.cargo/bin
    /usr/local/{s,}bin
    /usr/{s,}bin
    /{s,}bin
    /opt/puppetlabs/{s,}bin
    # ~/music/.bin
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

# If your home is writable.
if [[ -w ~ ]]; then
    export TMP=~/.local/tmp
    export TMPDIR=$TMP
    mkdir -p -m700 $TMP/emacs$UID
    mkdir -p -m700 ~/.ssh
    chmod -R go-rwx $TMP ~/.ssh
fi

local HOST=$(LC_ALL=C uname -n)
# export NULLCMD=:
export PERL_BADLANG=0
#unset  LC_ALL
export LANG=en_US.UTF-8
export LC_TIME=en_GB.UTF-8
#export LC_COLLATE=C
#export LC_ALL
export TZ=Europe/Vienna
# See this thread: https://www.zsh.org/mla/workers/2022/msg00814.html
export RSYNC_OLD_ARGS=1

# Only set this variable if running in X
[ "$XAUTHORITY" ] && export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'

unset WORDCHARS

# Don't wanna know I got new mail :P
unset mailpath MAILCHECK

# If you don't like what is set here, I recommend you edit ~/.zlocal
export GIT_AUTHOR_NAME="${GIT_AUTHOR_NAME:-$(getent passwd $USER|awk -F : '{print $5}')}"
export GIT_AUTHOR_EMAIL="${GIT_AUTHOR_EMAIL:-$USER@$DOMAIN}"
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

# For CVS
export CVS_RSH=ssh
