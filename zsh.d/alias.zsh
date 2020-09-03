if ! id -u |\grep -q '^0$'; then
    alias vipw='EDITOR=sudoedit sudo vipw'
    alias visudo='VISUAL=sudoedit EDITOR=sudoedit sudo visudo'
fi

if isinst rsync; then
    alias rsync='rsync -a --info=progress2 --partial'
    alias vsync='rsync --modify-window=1 -rtv --delete --no-p --no-g'
fi

# My shells often last longer than the settings.
alias r="rehash"
alias rr="(cd ~/.configs && git pull) >& /dev/null; source $ZDOTDIR/.zshrc"
alias mv='mv -i'
alias cp='cp -i'
alias p='cd -'

alias ls='ls --color=auto -N'
alias l='ls -lvha'
alias t='l -rt'
alias s='l -rS'

alias df='df -h | \grep -v \^tmpfs'
alias cvsup='cvs -q up -PAd'
alias c='cd; clear'

isinst htop   && alias top='htop'
isinst geeqie && alias gqview='geeqie'
isinst wcalc  && alias calc='wcalc'
isinst pwgen  && alias pwgen='pwgen -y 12 1'
# To check which compiler was used to compile a binary.
isinst objdump && alias which_compiler='objdump --full-contents --section=.comment'
isinst mycli   && alias mycli='LANG=C.UTF8 LC_ALL=C.UTF-8 mycli'
isinst xclip   && alias xclip_image='xclip -selection clipboard -t image/png -i'

# Global aliases
alias -g L='|less'
alias -g G='|grep'
alias -g H='|head'
alias -g T='|tail'
alias -g S='|sort'

alias genpasswd='< /dev/urandom tr -dc "a-zA-Z0-9" | dd count=1 bs=12 2> /dev/null; echo'
alias genpasswd2='< /dev/urandom tr -dc "[:graph:]" | dd count=1 bs=12 2> /dev/null; echo'
alias genpin='< /dev/urandom tr -dc "0-9" | dd count=1 bs=4 2> /dev/null; echo'
