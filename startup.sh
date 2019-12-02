GLAD_PI_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "$GLAD_PI_DIR/vars.sh"

"$GLAD_PI_DIR/setup-wifi-monitor.sh" | tee "$GLAD_PI_LOGS/setup-wifi-monitor.sh"
