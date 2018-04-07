#!/bin/sh -x

# You can run this script on a remote host like this:
# ssh root@172.16.4.1 'bash -s' < puppet.sh

cd ~

for i in apt-get yum pkg_add prt-get apk; do
    command -v $i > /dev/null 2>&1 && installer=$i && break
done

case $installer in
    apk)
        install=add
        ;;
    *)
        install="install -y"
        ;;
esac

install_package() {
    for i in $*; do
        case $i in
            *:*)
                command -v ${i%:*} > /dev/null || sudo $installer $install ${i#*:}
                ;;
            *)
                command -v $i > /dev/null || sudo $installer $install $i
                ;;
        esac
    done
}

[ "$installer" = "yum" ] && [ ! -f /etc/yum.repos.d/epel.repo ] && sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

case $installer in
    apk)
        install_package zsh git mg htop tmux ag:the_silver_searcher
        ;;
    *)
        install_package zsh git mg htop tmux ag:the_silver_searcher w3m colordiff iotop
        ;;
esac

[ -d .configs ] || git clone https://github.com/hboetes/configs.git .configs

grep -q "^$USER:.*/bin/zsh$" /etc/passwd || chsh -s /bin/zsh

mkdir -p .config

for i in .configs/.config/{htop,mc,terminator}; do
    [ -h .config/${i##*/} ] || ln -sf $i .config
done

for i in .configs/{.colordiffrc,.emacs.d,.mg,.w3m,zsh.d/.zshenv,.configs/.config/fontconfig,.gitconfig,.tmux.conf}; do
    [ -h ${i##*/} ] || ln -sf $i
done

[ -f .tmux.local ] || cp .configs/.tmux.local .

# Only install this stuff if X is installed.
command -v X ||  exit 0

install_package i3wm rofi diodon redshift-gtk mpv

# Set up the right apps to open pgn and magnet links.
xdg-desktop-menu install --mode user --novendor .configs/pgnhandler.desktop
xdg-desktop-menu install --mode user --novendor .configs/magnethandler.desktop

for i in .configs/.config/{i3,i3blocks}; do
    [ -h .config/${i##*/} ] || ln -sf $i .config
done
