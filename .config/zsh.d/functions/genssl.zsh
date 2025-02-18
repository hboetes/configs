gensslcsr()
{
    if [ -z "$1" ]; then
        echo "This function requires an argument: A name. :P" >&2
    else
        (
            umask 077
            fqdn="$1.axis-flight-training-systems.at"
            openssl req -nodes -newkey rsa:2048 -keyout $1.axis-flight-training-systems.at.key -out $1.axis-flight-training-systems.at.csr -subj "/C=AT/ST=Steiermark/L=Lebring/O=Axis Flight Training Systems GmbH/OU=IT/CN=$1.axis-flight-training-systems.at"
            echo "Principal alias: host/$fqdn@AXIS-FLIGHT-TRAINING-SYSTEMS.AT"
            cat $fqdn.csr
        )
    fi
}
