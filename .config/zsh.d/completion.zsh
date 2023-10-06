# For my own custom completers
fpath=($ZDOTDIR/completers $fpath)

# Completion Styles
autoload -U compinit
compinit -d $TMP/zcompdump-$HOST

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored #_approximate

# Insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# Formatting and messages.
zstyle ':completion:*' verbose no #yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'

# Offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Command for process lists, the local web server details and host
# completion.
zstyle ':completion:*:processes' command 'ps x -o pid,nice,pcpu,tt,args'

# Hosts to use for completion, see later zstyle.
zstyle '*' hosts $(awk '/^[^#]/ {print $3" "$4" "$5}' /etc/hosts)

# Filename suffixes to ignore during completion, except after rm
# command.
zstyle ':completion:*:*:(^rm):*:*files' ignored-patterns \
       '*?.o' '*~' # '*?.orig'

# Ignore completion functions, until the _ignored completer.
zstyle ':completion:*:functions' ignored-patterns '_*'

# Disable unused completers.
compdef _default \
        apm archie arp arping cvsup \
        dict dictwords domains \
        fetchmail figlet finger groups iconv imagemagick \
        ispell java lp mailboxes mail make-kpkg \
        mplayer ncftp nedit netscape newsgroups pine printers \
        print rlogin slrn spamassassin texi \
        texinfo tiff tin userathost users userson w3m yp urpmi

# Now that all completers are defined...
rehash

# Automatically rehash
zstyle ':completion:*' rehash true
