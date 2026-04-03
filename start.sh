#!/bin/bash
set -e

DISPLAY_WIDTH="${DISPLAY_WIDTH:-1600}"
DISPLAY_HEIGHT="${DISPLAY_HEIGHT:-900}"
PORT="${PORT:-7860}"

rm -f /tmp/.X1-lock /tmp/.X11-unix/X1 2>/dev/null || true

# Start TigerVNC without password (noVNC handles access)
Xtigervnc :1 \
    -geometry "${DISPLAY_WIDTH}x${DISPLAY_HEIGHT}" \
    -depth 24 \
    -rfbport 5901 \
    -SecurityTypes None \
    -localhost no &
sleep 2

export DISPLAY=:1
xsetroot -solid '#1a1a2e' || true

openbox-session &
sleep 2

echo "Starting noVNC on port ${PORT}"
exec websockify \
    --web=/usr/share/novnc/ \
    --heartbeat=30 \
    0.0.0.0:${PORT} \
    localhost:5901
