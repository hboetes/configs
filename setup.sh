#!/bin/sh -x

# You can run this script on a remote host like this:
# ssh root@172.16.4.1 'bash -s' < puppet.sh

cd ~

installed()
{
    command -v $1 > /dev/null
}

for i in apt-get yum pkg_add prt-get apk pacman; do
    installed $i && installer=$i && break
done

sudo=$(which sudo 2> /dev/null )

case $installer in
    apk)
        install=add
        ;;
    pkg)
        install=install
        ;;
    pacman)
        install='-S --noconfirm'
        ;;
    *)
        install="install -y"
        ;;
esac

if [ $(id -u) != 0 ]; then
    sudo=sudo
fi

install_package() {
    for i in $*; do
        case $i in
            *:*)
                installed ${i%:*} || $sudo $installer $install ${i#*:}
                ;;
            *)
                installed $i || $sudo $installer $install $i
                ;;
        esac
    done
}

[ "$installer" = "yum" ] && [ ! -f /etc/yum.repos.d/epel.repo ] && $sudo yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

case $installer in
    apk)
        install_package zsh git mg htop tmux ag:the_silver_searcher rsync
        ;;
    *)
        install_package zsh git mg htop tmux ag:the_silver_searcher w3m colordiff iotop coreutils rsync
        ;;
esac

[ -d .configs ] || git clone https://github.com/hboetes/configs.git .configs

installed zsh && grep -q "^$USER:.*/bin/zsh$" /etc/passwd || chsh -s $(which zsh)

mkdir -p .config

for i in .configs/.config/htop .configs/.config/mc .configs/.config/terminator .configs/.config/fontconfig; do
    [ -h .config/${i##*/} ] || ln -sf ../$i .config
done

for i in .configs/.colordiffrc .configs/.emacs.d .configs/.mg .configs/.w3m .configs/zsh.d/.zshenv .configs/.gitconfig .configs/.tmux.conf; do
    [ -h ${i##*/} ] || ln -sf $i
done

[ -f .tmux.local ] || cp .configs/.tmux.local .

# Only install this stuff if X is installed.
installed X ||  exit 0

install_package i3-wm rofi diodon redshift-gtk mpv

# Set up the right apps to open pgn and magnet links.
xdg-desktop-menu install --mode user --novendor .configs/pgnhandler.desktop
xdg-desktop-menu install --mode user --novendor .configs/magnethandler.desktop

for i in .configs/.config/i3 .configs/.config/i3blocks; do
    [ -h .config/${i##*/} ] || ln -sf $i .config
done
