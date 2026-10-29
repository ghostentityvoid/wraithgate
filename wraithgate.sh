[[ $- != *i* ]] && return
# WRAITHGATE - a mysterious Termux terminal experience
# powered by Cybervynq

WG_DIR="$HOME/.wraithgate"
WG_ALIAS="$(cat "$WG_DIR/alias" 2>/dev/null)"

R=$'\e[1;31m'; r=$'\e[0;31m'; G=$'\e[1;32m'; g=$'\e[0;32m'
C=$'\e[1;36m'; W=$'\e[1;37m'; K=$'\e[90m'; X=$'\e[0m'
OUT=$'\e[0;32m'
GL=(▓ ▒ ░ █ ▌ ▐ ▄ ▀ ╳ ╬ ¦ § Ø ¤ ∆ ∑ Ω ≈ ‡ '#' '@' '%' '&' '?' '/' 0 1)
CL=("$R" "$G" "$C" "$W" "$K" "$r")

WG_GROUP="https://chat.whatsapp.com/C3qzE9Ej0RC6fdb63gFekQ"
WG_CHANNEL="https://whatsapp.com/channel/0029VbDvxqzLtOj9kQcyJL2N"

wg_nap() { sleep "0.$(printf '%02d' $(( RANDOM % $1 + $2 )))"; }
wg_cols() { tput cols 2>/dev/null || echo 40; }

wg_glitch() {
  local t="$1" n="${2:-6}" fin="${3:-$G}" cols f i ch out len
  cols=$(wg_cols)
  t="${t:0:$((cols-1))}"; len=${#t}
  for ((f=0; f<n; f++)); do
    out=""
    for ((i=0; i<len; i++)); do
      ch="${t:i:1}"
      if [[ "$ch" != " " ]] && (( RANDOM % 100 < (n-f)*60/n )); then
        out+="${CL[RANDOM % ${#CL[@]}]}${GL[RANDOM % ${#GL[@]}]}"
      else
        out+="${fin}${ch}"
      fi
    done
    printf '\r%s%s' "$out" "$X"
    sleep 0.05
  done
  printf '\r%s%s%s\n' "$fin" "$t" "$X"
}

wg_flicker() {
  local i
  for i in 1 2 3; do
    printf '\e[?5h'; sleep 0.04; printf '\e[?5l'; sleep 0.07
  done
}

wg_whisper() {
  local who="${WG_ALIAS:-stranger}"
  local m=(
    "you were not supposed to see this."
    "it knows you are here."
    "do not trust the silence."
    "someone else is in this session."
    "the dark remembers your name."
    "every keystroke is being watched."
    "you opened the door. it noticed."
    "do not look behind the screen."
    "it is already inside."
    "no one ever logs out of here."
    "your signal was never private."
    "we have been waiting for you."
    "it learned your breathing pattern."
    "the last user never came back."
    "if you are not ${who}, close this now."
    "looking at this screen was a mistake."
  )
  wg_glitch " ▸ ${m[RANDOM % ${#m[@]}]}" 6 "$r"
}

wg_hex() {
  local n=${1:-8} i j line part
  local procs=("unknown process attached" "memory not yours" "pid 0 is awake" "channel opened from inside" "a watcher joined" "unreadable sector breathing" "your device is not alone")
  for ((i=0; i<n; i++)); do
    printf -v line '0x%08x ' $(( (RANDOM<<15) | RANDOM ))
    for ((j=0; j<8; j++)); do printf -v part '%02x ' $((RANDOM%256)); line+=$part; done
    if (( RANDOM % 5 == 0 )); then
      printf '%s ▸ %s%s\n' "$R" "${procs[RANDOM % ${#procs[@]}]}" "$X"
    else
      printf '%s%s%s\n' "$K" "$line" "$X"
    fi
    wg_nap 8 1
  done
}

wg_static() {
  local n=${1:-7} cols i j line
  cols=$(wg_cols)
  for ((i=0; i<n; i++)); do
    line=""
    for ((j=0; j<cols-1; j++)); do line+="${GL[RANDOM % ${#GL[@]}]}"; done
    printf '%s%s%s\n' "${CL[RANDOM % ${#CL[@]}]}" "$line" "$X"
    sleep 0.04
  done
}

wg_bar() {
  local p=$1 f=$(( $1 / 5 )) i bar=""
  for ((i=0; i<20; i++)); do ((i<f)) && bar+="█" || bar+="░"; done
  printf '\r\e[2K%s[%s] %3d%%%s %s' "$G" "$bar" "$p" "$X" "$2"
}

# ───────── the hand (sketched, broken lines) ─────────

wg_finger() {
  local art=() n line out ch i pr col first=1 w=0 cols
  local f="$WG_DIR/finger.txt"
  local pick=(
    "you were never invited."
    "whoever you are: look away."
    "this machine answers to one master."
    "touch nothing. it is watching your hands."
    "curiosity is how they all started."
  )
  [ -f "$f" ] && mapfile -t art < "$f"
  n=${#art[@]}
  for line in "${art[@]}"; do ((${#line} > w)) && w=${#line}; done
  cols=$(wg_cols)
  echo
  if ((n > 0 && cols >= w + 2)); then
    for pr in 35 60 85 100; do
      if ((first)); then first=0; else printf '\e[%dA' "$n"; fi
      if ((pr < 100)); then col="$g"; else col="$G"; fi
      for line in "${art[@]}"; do
        out=""
        for ((i=0; i<${#line}; i++)); do
          ch="${line:i:1}"
          if [[ "$ch" != " " ]] && (( RANDOM % 100 >= pr )); then ch=" "; fi
          out+="$ch"
        done
        printf '\e[2K %s%s%s\n' "$col" "$out" "$X"
        sleep 0.02
      done
      sleep 0.4
    done
    sleep 0.4
    wg_flicker
  fi
  echo
  sleep 0.5
  wg_glitch " ▸ ${pick[RANDOM % ${#pick[@]}]}" 8 "$R"
  sleep 0.5
  wg_glitch " ▸ this is the gate's domain." 8 "$r"
  sleep 1.6
  wg_flicker
}
wg_links() {
  echo "${K} ── join the circle ──${X}"
  echo "${C} group:${X}"
  echo "${W} ${WG_GROUP}${X}"
  echo "${C} channel:${X}"
  echo "${W} ${WG_CHANNEL}${X}"
}

wg_banner() {
  local node=$((RANDOM % 900 + 100))
  local l="▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀▄▀"
  echo
  echo "${r}${l}${X}"
  wg_glitch "  W R A I T H G A T E" 10 "$R"
  echo "${K}  [ you are being observed ]${X}"
  echo "${K}  powered by Cybervynq${X}"
  echo "${r}${l}${X}"
  echo "${g} node  : ghost-${node}${X}"
  echo "${g} time  : $(date '+%a %d %b %Y | %H:%M')${X}"
  echo "${g} trace : ${R}ACTIVE${X}"
  echo
  wg_links
  echo
  wg_whisper
  echo
}

# ───────── alias (asked on first launch) ─────────
wg_set_alias() {
  local a="$1"
  if [ -z "$a" ]; then
    command clear
    echo
    wg_glitch " ▸ identify yourself." 8 "$R"
    wg_glitch " ▸ the gate needs a name to remember you by." 6 "$r"
    echo
    printf '%s ▸ alias: %s' "$G" "$X"
    read -r a
  fi
  a=${a//[^A-Za-z0-9_.-]/}
  a=${a:0:16}
  [ -z "$a" ] && a="stranger"
  mkdir -p "$WG_DIR"
  printf '%s\n' "$a" > "$WG_DIR/alias"
  WG_ALIAS="$a"
  wg_glitch " ▸ ${a}. the gate will remember." 6 "$R"
  sleep 1
}
wgalias() { wg_set_alias "$1"; }

# ───────── boot (unskippable, different every launch) ─────────
wg_boot() {
  trap '' INT QUIT TSTP
  stty -echo 2>/dev/null
  printf '\e[?25l'
  local steps tk s i k=0 p=0 took=0

  case $((RANDOM % 5)) in
    0) steps=("probing the dark" "listening for breathing" "something answered back" "wiping your name from the logs" "the door is open now")
       tk="stop loading. turn back." ;;
    1) steps=("counting the watchers" "they stopped moving" "rewriting what you remember" "this line was not written by you" "do not look at the screen")
       tk="it can see your face." ;;
    2) steps=("unsealing what was buried" "the signal has teeth" "following you home" "your shadow logged in first" "it is behind the prompt")
       tk="you should not have come back." ;;
    3) steps=("scanning every device near you" "found you" "your location is no longer yours" "copying what you fear" "it knows what you did")
       tk="whoever is reading this is already marked." ;;
    4) steps=("opening the room with no walls" "something is typing back" "your reflection logged out" "the screen is not a window" "it was always here")
       tk="close your eyes. it will not help." ;;
  esac

  command clear
  sleep 0.7
  wg_hex $((RANDOM % 5 + 6))
  sleep 0.3

  for s in "${steps[@]}"; do
    wg_glitch " [*] $s" 5 "$g"
    k=$((k+1))
    if ((k==3)); then
      printf '%s [*] ' "$K"
      for i in 1 2 3 4 5; do sleep 0.35; printf '. '; done
      printf '%s\n' "$X"
      sleep 1.1
    fi
    (( RANDOM % 2 )) && wg_hex 2
    wg_nap 60 20
  done

  echo
  while ((p<99)); do
    p=$((p + RANDOM % 9 + 1)); ((p>99)) && p=99
    wg_bar $p
    if ((!took && p>=60)); then
      took=1
      sleep 0.5; wg_flicker
      printf '\r\e[2K'
      wg_glitch " ▸ $tk" 8 "$R"
      sleep 1.3
      printf '\e[1A\e[2K'
      printf '%s ▸ ...ignore that.%s\n' "$K" "$X"
      sleep 0.9
      printf '\e[1A\e[2K'
    fi
    if (( RANDOM % 6 == 0 )); then sleep 0.6; else wg_nap 12 3; fi
  done
  sleep 1.6
  wg_bar 100
  echo; sleep 0.5

  wg_flicker
  command clear
  sleep 1.2
  wg_static 7
  command clear
  sleep 0.6
  wg_glitch " intruder alert. ...no. it is only you." 8 "$r"
  sleep 0.9
  wg_finger
  command clear
  sleep 0.5
  wg_banner
  wg_glitch " ACCESS GRANTED" 10 "$R"
  sleep 0.4
  wg_glitch " welcome back, ${WG_ALIAS:-stranger}. it waited." 8 "$r"
  sleep 0.8
  wg_flicker

  while read -r -s -t 0.02 -n 256 _ 2>/dev/null; do :; done
  stty echo 2>/dev/null
  printf '\e[?25h'
  trap - INT QUIT TSTP
}

# ───────── commands ─────────
restart() { wg_boot; }                       # replay the full boot
clear() { command clear; wg_banner; }        # quick wipe, UI stays
bind -x '"\C-l":"clear"' 2>/dev/null
wgjoin() { echo; wg_links; echo; }           # print the community links

# ───────── every command: mysterious loading + message ─────────
wg_anim() {
  local cmd="${1:0:12}" frames=$((RANDOM % 12 + 24)) f i st=$((RANDOM % 4)) p line hit=-1 lab m
  local labs=("waking" "tracing" "binding" "unsealing" "watching" "feeding" "haunting")
  local sp=(⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏)
  local pre=("the void permits '%s'." "'%s' was expected." "'%s' has been logged." "do not trust what '%s' returns." "'%s' wakes something up.")
  lab="${labs[RANDOM % ${#labs[@]}]}"
  (( RANDOM % 3 == 0 )) && hit=$((frames * 2 / 3))
  printf '\e[?25l'
  for ((f=0; f<frames; f++)); do
    case $st in
      0) p=$((f * 100 / frames)); wg_bar $p "$cmd" ;;
      1) printf -v line '%04x:%04x:%04x:%04x' $RANDOM $RANDOM $RANDOM $RANDOM
         printf '\r\e[2K%s%s %s%s' "$K" "$line" "$cmd" "$X" ;;
      2) printf '\r\e[2K%s%s %s %s%s' "$G" "${sp[f % 10]}" "$lab" "$cmd" "$X" ;;
      3) line=""
         for ((i=0; i<20; i++)); do
           if ((i < f * 20 / frames)); then line+="${G}█"
           else line+="${CL[RANDOM % 6]}${GL[RANDOM % ${#GL[@]}]}"; fi
         done
         printf '\r\e[2K%s%s %s' "$line" "$X" "$cmd" ;;
    esac
    if ((f==hit)); then
      sleep 0.35; wg_flicker
      printf '\r\e[2K%s ▸ it noticed you.%s' "$R" "$X"
      sleep 0.6
    fi
    sleep 0.05
  done
  printf '\r\e[2K\e[?25h'
  printf -v m "${pre[RANDOM % ${#pre[@]}]}" "$cmd"
  printf '%s ▸ %s%s\n%s' "$r" "$m" "$X" "$OUT"
}

WG_ANIM=1; WG_READY=0; WG_RAN=0
wganim() {
  case "$1" in
    off) WG_ANIM=0; echo "the watcher sleeps. for now." ;;
    on)  WG_ANIM=1; echo "it is awake again." ;;
    *)   echo "usage: wganim on|off" ;;
  esac
}

wg_debug() {
  (( WG_READY )) || return 0
  WG_READY=0
  [[ "$WG_ANIM" == 0 ]] && return 0
  case "$BASH_COMMAND" in
    wg_*|clear*|restart*|wgalias*|wganim*|wgjoin*|exit*|logout*|"") return 0 ;;
  esac
  [ -t 2 ] || return 0
  WG_RAN=1
  wg_anim "${BASH_COMMAND%% *}"
  return 0
}

wg_prompt() {
  local rc=$? m
  local ok=("it is done. it remembers." "no trace left." "the dark accepts this." "it watched you do it." "nothing was lost. nothing was kept.")
  local bad=("it refused. [%s]" "something blocked the way. [%s]" "the void said no. [%s]" "it failed. it was never meant to work. [%s]")
  if ((WG_RAN)); then
    if ((rc)); then
      printf -v m "${bad[RANDOM % ${#bad[@]}]}" "$rc"
      printf '%s ▸ %s%s\n' "$R" "$m" "$X"
    else
      printf '%s ▸ %s%s\n' "$g" "${ok[RANDOM % ${#ok[@]}]}" "$X"
    fi
    WG_RAN=0
  fi
  if ((rc)); then WG_S=$'\001\e[1;31m\002✖ '"$rc"$'\001\e[0m\002'
  else WG_S=$'\001\e[1;32m\002✔'$'\001\e[0m\002'; fi
  WG_READY=1
  return $rc
}
PROMPT_COMMAND=wg_prompt
PS0=$'\e[0;32m'
PS1='\[\e[0m\]\[\e[1;31m\]┌─[\[\e[1;32m\]${WG_ALIAS:-ghost}@wraithgate\[\e[1;31m\]]─[\[\e[0;37m\]\w\[\e[1;31m\]]─[${WG_S}\[\e[1;31m\]]\n└─▶ \[\e[0;37m\]'

alias ls='ls --color=auto'
alias grep='grep --color=auto'
export LS_COLORS="di=1;32:ln=1;36:ex=1;31:fi=0;32:*.php=1;33:*.sql=1;35"
export GREP_COLORS='ms=01;31'

command_not_found_handle() {
  local a=("'$1' does not exist here." "'$1' is not in this world." "'$1' does not answer. it never will.")
  echo "${R} ✖ ${a[RANDOM % 3]}${X}" >&2
  return 127
}

# first launch of the session: ask for alias once, then boot
if [ -z "$WG_LOADED" ]; then
  export WG_LOADED=1
  [ -z "$WG_ALIAS" ] && wg_set_alias
  wg_boot
fi

trap 'wg_debug' DEBUG
