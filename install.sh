#!/usr/bin/env bash
# WRAITHGATE installer (Termux) - powered by Cybervynq
set -e
HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="$HOME/.wraithgate"
T="$HOME/.termux"
LINE='[ -f "$HOME/.wraithgate/wraithgate.sh" ] && source "$HOME/.wraithgate/wraithgate.sh"'
SWITCH='[ -f "$HOME/.wraithgate/switch.sh" ] && source "$HOME/.wraithgate/switch.sh"'

mkdir -p "$DEST" "$T"
cp "$HERE/wraithgate.sh" "$HERE/switch.sh" "$HERE/motd.default" "$HERE/finger.txt" "$DEST/"
cp "$HERE/colors.properties" "$DEST/theme.properties"

# keep the user's own colors (only if they are not already ours)
if [ -f "$T/colors.properties" ] && [ ! -f "$T/colors.properties.bak" ] \
   && ! cmp -s "$T/colors.properties" "$HERE/colors.properties"; then
  cp "$T/colors.properties" "$T/colors.properties.bak"
fi
cp "$HERE/colors.properties" "$T/colors.properties"

# silence the default welcome text (WRAITHGATE OFF puts it back)
touch "$HOME/.hushlogin"
[ -n "$PREFIX" ] && rm -f "$PREFIX/etc/motd"

# hook into bash (no duplicates)
touch "$HOME/.bashrc"
grep -qF 'switch.sh' "$HOME/.bashrc" || echo "$SWITCH" >> "$HOME/.bashrc"
grep -qF 'wraithgate.sh' "$HOME/.bashrc" || echo "$LINE" >> "$HOME/.bashrc"

command -v termux-reload-settings >/dev/null 2>&1 && termux-reload-settings

echo
echo "WRAITHGATE installed."
echo "Close Termux fully and open it again, or run:  exec bash"
echo "Switch:   WRAITHGATE OFF  |  WRAITHGATE ON"
echo "Commands: restart | clear | wgalias | wgjoin | wganim on|off"
