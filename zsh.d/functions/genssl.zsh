gensslkey()
{
    if [ -z "$1" ]; then
        echo "This function requires an argument: A name. :P" >&2
    else
        (
            umask 077
            openssl genrsa -out $1.key 2048
            openssl req -new -key $1.key -out $1.csr
            openssl x509 -req -days 365 -in $1.csr -signkey $1.key -out $1.crt
        )
    fi
}
