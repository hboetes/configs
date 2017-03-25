saneperms()
{
    find . -type d -exec chmod 0755 {} \;
    find . -type f -exec chmod ${1:=0644} {} \;
}
