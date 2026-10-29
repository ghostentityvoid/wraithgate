[[ $- != *i* ]] && return
# WRAITHGATE on/off switch - always loaded, even when WRAITHGATE is off
# powered by Cybervynq

WRAITHGATE() {
  local D="$HOME/.wraithgate" T="$HOME/.termux"
  case "${1,,}" in
    off)
      sed -i 's/^\[ -f.*wraithgate\.sh.*/#&/' "$HOME/.bashrc"
      # put back the original Termux look: colors, cursor, welcome text
      if [ -f "$T/colors.properties.bak" ]; then
        cp "$T/colors.properties.bak" "$T/colors.properties"
      else
        rm -f "$T/colors.properties"
      fi
      rm -f "$HOME/.hushlogin"
      if [ -n "$PREFIX" ] && [ -f "$D/motd.default" ]; then
        cp "$D/motd.default" "$PREFIX/etc/motd"
      fi
      command -v termux-reload-settings >/dev/null 2>&1 && termux-reload-settings
      unset WG_LOADED LS_COLORS GREP_COLORS
      command clear
      [ -n "$PREFIX" ] && [ -f "$PREFIX/etc/motd" ] && cat "$PREFIX/etc/motd"
      exec bash ;;
    on)
      sed -i 's/^#\(\[ -f.*wraithgate\.sh.*\)/\1/' "$HOME/.bashrc"
      [ -f "$D/theme.properties" ] && cp "$D/theme.properties" "$T/colors.properties"
      touch "$HOME/.hushlogin"
      [ -n "$PREFIX" ] && rm -f "$PREFIX/etc/motd"
      command -v termux-reload-settings >/dev/null 2>&1 && termux-reload-settings
      unset WG_LOADED
      echo "waking WRAITHGATE..."
      sleep 1
      exec bash ;;
    *)
      echo "usage: WRAITHGATE ON | WRAITHGATE OFF" ;;
  esac
}
