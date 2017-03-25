ldd_forlibs()
{
    objdump -p $1 | awk '/NEEDED/ {print $2}'
}
