#!/bin/bash
GLAD_PI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$GLAD_PI_DIR/vars.sh"

if [ ! -d "$WIFI_DEVICE" ]; then
  # Control will enter here if $DIRECTORY doesn't exist.
  #   Exports pin to userspace
  echo "$WIFI_RELAY_PIN" > /sys/class/gpio/export
fi

DIRECTION=$(cat "$WIFI_DEVICE/direction")
# Sets pin as an output
if [ "$DIRECTION" != "out" ]; then
    echo "out" > "$WIFI_DEVICE"/direction
    echo "$WIFI_DEVICE set to output"
else
    echo "$WIFI_DEVICE already set to output"
fi

"$GLAD_PI_DIR/onHostapdChange.sh" | tee "$GLAD_PI_LOGS/onHostapdChange.log"
sudo pkill -f "hostapd_cli -a $GLAD_PI_DIR/onHostapdChange.sh"
sudo hostapd_cli -a "$GLAD_PI_DIR/onHostapdChange.sh" > "$GLAD_PI_LOGS/hostapd_onHostapdChange.log" 2>&1 & disown
