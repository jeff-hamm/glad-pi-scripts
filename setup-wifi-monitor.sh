#!/bin/bash


WIFI_RELAY_PIN=17
export WIFI_RELAY_PIN
#   Exports pin to userspace
echo "$WIFI_RELAY_PIN" > /sys/class/gpio/export                  

# Sets pin as an output
echo "out" > /sys/class/gpio/gpio"$WIFI_RELAY_PIN"/direction

. "$GLAD_PI_DIR/onHostapdChange.sh" > '$GLAD_PI_LOGS/onHostapdChange.log' 2>&1

hostapd_cli -a '$GLAD_PI_DIR/onHostapdChange.sh $WIFI_RELAY_PIN' > '$GLAD_PI_LOGS/onHostapdChange.log' 2>&1 &
