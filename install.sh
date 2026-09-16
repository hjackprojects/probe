#!/bin/sh
set -eu

PROBE_ZIP_URL="${PROBE_ZIP_URL:-https://cdn.jsdelivr.net/gh/hjackprojects/probe@main/probe-cli.zip}"
PROBE_ROOT="${HOME}/.local/share/probe"
PROBE_BIN="${HOME}/.local/bin"
PROBE_TEMP="$(mktemp -d)"

cleanup() {
  rm -rf "$PROBE_TEMP"
}
trap cleanup EXIT INT TERM

command -v node >/dev/null 2>&1 || { echo "Node.js 18+ is required." >&2; exit 1; }
command -v curl >/dev/null 2>&1 || { echo "curl is required." >&2; exit 1; }
command -v unzip >/dev/null 2>&1 || { echo "unzip is required." >&2; exit 1; }

mkdir -p "$PROBE_ROOT" "$PROBE_BIN"
curl -fsSL "$PROBE_ZIP_URL" -o "$PROBE_TEMP/probe-cli.zip"
unzip -oq "$PROBE_TEMP/probe-cli.zip" -d "$PROBE_ROOT"

cd "$PROBE_ROOT"
npm install --omit=dev --no-audit --no-fund

ln -sf "$PROBE_ROOT/bin/probe.js" "$PROBE_BIN/probe"
chmod +x "$PROBE_ROOT/bin/probe.js" "$PROBE_BIN/probe"

case ":${PATH}:" in
  *":${PROBE_BIN}:"*) ;;
  *) echo "Add this to your shell profile, then open a new terminal:" >&2
     echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >&2 ;;
esac

echo "Probe installed. Run: probe obfuscate input.lua 1732810323 protected.lua"
