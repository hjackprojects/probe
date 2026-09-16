#!/bin/sh
set -eu

PROBE_ROOT="${HOME}/.local/share/probe"
PROBE_COMMAND="${HOME}/.local/bin/probe"

echo "Uninstalling Probe..."

if [ -e "$PROBE_COMMAND" ] || [ -L "$PROBE_COMMAND" ]; then
    rm -f "$PROBE_COMMAND"
    echo "Removed: $PROBE_COMMAND"
fi

if [ -d "$PROBE_ROOT" ]; then
    rm -rf "$PROBE_ROOT"
    echo "Removed: $PROBE_ROOT"
fi

echo "Probe has been uninstalled."
