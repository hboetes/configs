emacs_upgrade_packages()
{
    echo 'upgrading emacs packages'
    emacs -batch -u "$USER" -f auto-package-update-now -kill
}
