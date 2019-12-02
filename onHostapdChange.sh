#!/bin/bash
echo_time() {
    date +"%H:%M $(printf "%s " "$@" | sed 's/%/%%/g')"
}

toggleWifi() {
	if . "GLAD_PI_DIR/wapsurvey.sh"; then
		echo_time "Turning on Wifi"
		echo "1" > /sys/class/gpio/gpio"$WIFI_RELAY_PIN"/value
	else
		echo_time "Turning off Wifi"
		echo "0" > /sys/class/gpio/gpio"$WIFI_RELAY_PIN"/value	
	fi
}

if [ $# -eq 0 ]
  then
    toggleWifi()
fi
if [[ $2 == "AP-STA-CONNECTED" ]]
then
  echo_time "new connection mac id $3 on $1"
  toggleWifi()
fi

if [[ $2 == "AP-STA-DISCONNECTED" ]]
then
  echo_time "disconnection with mac id $3 on $1"
  toggleWifi()
fi
