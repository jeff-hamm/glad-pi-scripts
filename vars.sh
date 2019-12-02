GLAD_PI_DIR=/opt/glad-pi-scripts
export GLAD_PI_DIR

GLAD_PI_LOGS="$GLAD_PI_DIR/logs"
mkdir -p "$GLAD_PI_LOGS"
export GLAD_PI_LOGS

echo_time() {
    date +"%H:%M $(printf "%s " "$@" | sed 's/%/%%/g')"
}

export -f echo_time

WIFI_RELAY_PIN=17
export WIFI_RELAY_PIN
WIFI_DEVICE="/sys/class/gpio/gpio$WIFI_RELAY_PIN"
export WIFI_DEVICE
