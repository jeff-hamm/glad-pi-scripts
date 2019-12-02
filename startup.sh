GLAD_PI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export GLAD_PI_DIR

GLAD_PI_LOGS="$GLAD_PI_DIR/logs"
mkdir -p GLAD_PI_LOGS
export GLAD_PI_LOGS

echo_time() {
    date +"%H:%M $(printf "%s " "$@" | sed 's/%/%%/g')"
}
export -f echo_time

. "$GLAD_PI_DIR/setup-wifi-monitor.sh"