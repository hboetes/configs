saneperms()
{
    find . -type d ! -perm 755 -exec chmod 0755 {} \;
    find . -type f ! -perm ${1:=0644} -exec chmod ${1:=0644} {} \;
}
