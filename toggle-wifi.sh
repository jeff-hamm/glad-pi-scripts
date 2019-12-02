GLAD_PI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$GLAD_PI_DIR/vars.sh"

atcmd() {
	time="now + $1 minute"
	shift;
	at_output=$(printf %s "$@" | LANGUAGE= LC_ALL=C at -q c -M $time 2>&1)
	at_status=$?
	if [ "$at_status" -ne 0 ]; then
	  echo "at $time failed with status $at_status" >&2
	  echo "$at_output"
	  exit $at_status
	fi
	newline='
	'
	case "$at_output" in
	  "job "*) at_job=${at_output#job };;
	  *"${newline}job "*) at_job=${at_output#*"${newline}job "};;
	  *) echo >&2 "$at_output"; echo >&2 "Unable to determine at job number!";;
	esac
	at_job=${at_job%% *}
	echo $at_job
}
WIFI_GPIO="/sys/class/gpio/gpio$WIFI_RELAY_PIN/value"
WIFI_VAL=$(cat "$WIFI_GPIO")
if "$GLAD_PI_DIR/wapsurvey.sh" wlan0 | tee "$GLAD_PI_LOGS/wapsurvey.log"; then
    if [ "$WIFI_VAL" != "1" ]; then
        echo_time "Turning on Wifi"
        echo "1" > "$WIFI_GPIO"
    else
        echo_time "Wifi already On"
    fi
    for i in $(atq -q c | cut -f 1); do atrm $i; done
elif [[ "$1" -eq "-f" ]]
then
    if [ "$WIFI_VAL" != "0" ]; then
        echo_time "Turning off Wifi"
        echo "0" > "$WIFI_GPIO"
    else
        echo_time "Wifi already off"
    fi
else
    echo_time "No clients connecting, turning off wifi in 5 minutes"
    echo "$0 -f" | at -q c -M now + 5 minutes
fi

