#!/bin/bash
GLAD_PI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$GLAD_PI_DIR/vars.sh"

toggleWifi() {
"$GLAD_PI_DIR/toggle-wifi.sh"
}

if [ $# -eq 0 ]
  then
    echo_time "Checking wifi state on startup"
    toggleWifi
fi

if [[ $2 == "AP-STA-CONNECTED" ]]
then
  echo_time "new connection mac id $3 on $1"
  toggleWifi
fi

if [[ $2 == "AP-STA-DISCONNECTED" ]]
then
  echo_time "disconnection with mac id $3 on $1"
  toggleWifi
fi
