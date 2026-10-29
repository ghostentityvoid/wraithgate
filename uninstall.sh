#!/usr/bin/env bash
# WRAITHGATE uninstaller - restores the original Termux look
T="$HOME/.termux"
sed -i '/\.wraithgate\//d' "$HOME/.bashrc" 2>/dev/null
if [ -f "$T/colors.properties.bak" ]; then
  mv "$T/colors.properties.bak" "$T/colors.properties"
else
  rm -f "$T/colors.properties"
fi
rm -f "$HOME/.hushlogin"
if [ -n "$PREFIX" ] && [ -f "$HOME/.wraithgate/motd.default" ]; then
  cp "$HOME/.wraithgate/motd.default" "$PREFIX/etc/motd"
fi
rm -rf "$HOME/.wraithgate"
command -v termux-reload-settings >/dev/null 2>&1 && termux-reload-settings
echo "WRAITHGATE removed. Close Termux fully and reopen it for the default look."
