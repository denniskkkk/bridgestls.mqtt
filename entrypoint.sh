#!/bin/bash
set -eo pipefail
shopt -s nullglob
echo "...."
shutdown () {
   echo "......signals"
   kill $!
}

trap 'shutdown' SIGTERM
trap 'shutdown' USR1

_main () {
if [ "${1:0:1}" = '-' ]; then
    set -- bash 
    cat /etc/mosquitto/mosquitto.conf
else
    exec "$@"
    read pid < "/var/run/mosquitto.pid"
    echo "PID: $pid"
    wait $!
fi
}
_main "$@"
