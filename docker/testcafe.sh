#!/bin/sh
dbus-daemon --session --fork
Xvfb :1 -ac -screen 0 "$XVFB_WHD" -nolisten tcp +extension GLX +render -noreset >/dev/null 2>&1 &
export DISPLAY=:1.0
fluxbox >/dev/null 2>&1 &
cd /tests
echo "${TESTCAFE_CMD}"
/bin/sh -c "${TESTCAFE_CMD}"