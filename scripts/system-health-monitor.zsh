#!/usr/bin/env zsh
# sysmon.zsh — columned system dashboard for Termux

set -euo pipefail

# Colors
c_reset=$'%{\e[0m%}'
c_title=$'%{\e[36m%}'
c_key=$'%{\e[33m%}'
c_ok=$'%{\e[32m%}'
c_warn=$'%{\e[31m%}'

have() { command -v "$1" >/dev/null 2>&1; }

row() {
  # row "Section" "Key" "Value"
  printf "  %-10s │ %-14s │ %s\n" "$1" "$2" "$3"
}

section() {
  # section "Title"
  printf "\n%s== %s ==%s\n" "$c_title" "$1" "$c_reset"
  printf "  %-10s │ %-14s │ %s\n" "Scope" "Metric" "Value"
  printf "  %s\n" "───────────┼────────────────┼────────────────────────────────"
}

# Time / Uptime
upt="$(uptime -p 2>/dev/null || true)"
now="$(date '+%Y-%m-%d %H:%M:%S %Z')"

# CPU
load="$(uptime | awk -F'load average:' '{gsub(/^[ \t]+/,"",$2);print $2}')"

# Memory
read -r mt mu mf <<<"$(free -m | awk '/^Mem:/ {print $2, $3, $4}')"
mperc="$(awk -v u="$mu" -v t="$mt" 'BEGIN{if(t>0) printf("%.1f%%", (u/t)*100); else print "n/a"}')"

# Disk (Termux prefix)
read -r du dt dp da <<<"$(df -h "$PREFIX" | awk 'NR==2 {print $3, $2, $5, $4}')"

# Battery via termux-api + jq
batt_line="Unavailable"
if have termux-battery-status; then
  if have jq; then
    bjson="$(termux-battery-status 2>/dev/null || true)"
    if [[ -n "$bjson" ]]; then
      b_pct="$(printf %s "$bjson" | jq -r '.percentage // "n/a"')"
      b_stat="$(printf %s "$bjson" | jq -r '.status // "n/a"')"
      b_temp="$(printf %s "$bjson" | jq -r '.temperature // "n/a"')"
      b_health="$(printf %s "$bjson" | jq -r '.health // "n/a"')"
      batt_line="${b_pct}% | ${b_stat} | ${b_temp}°C | ${b_health}"
    fi
  else
    batt_line="Install jq for parsing"
  fi
else
  batt_line="Install Termux:API for battery"
fi

# Network IP (best-effort)
ip_addr="Not connected"
if have ip; then
  ip_addr="$(ip -4 route get 8.8.8.8 2>/dev/null | awk '/src/ {for(i=1;i<=NF;i++) if($i=="src") {print $(i+1); exit}}')"
  [[ -z "$ip_addr" ]] && ip_addr="Not connected"
elif have ifconfig; then
  ip_addr="$(ifconfig 2>/dev/null | awk '/inet / && $2!="127.0.0.1" {print $2; exit}')"
  [[ -z "$ip_addr" ]] && ip_addr="Not connected"
fi

# Header
printf "%s╔══════════════════════════════════════════════════════╗%s\n" "$c_ok" "$c_reset"
printf "%s║%s  System Monitor                                          %s║%s\n" "$c_ok" "$c_reset" "$c_ok" "$c_reset"
printf "%s╚══════════════════════════════════════════════════════╝%s\n" "$c_ok" "$c_reset"

# Sections
section "Time"
row "system" "Now" "$now"
row "system" "Uptime" "${upt:-n/a}"

section "CPU"
row "cpu" "Load avg" "${load:-n/a}"

section "Memory"
row "mem" "Used/Total" "${mu:-n/a}M / ${mt:-n/a}M"
row "mem" "Free" "${mf:-n/a}M"
row "mem" "Usage" "$mperc"

section "Disk"
row "disk" "Used/Total" "${du:-n/a} / ${dt:-n/a}"
row "disk" "Avail" "${da:-n/a}"
row "disk" "Usage" "${dp:-n/a}"

section "Battery"
row "battery" "Percent|State" "$batt_line"

section "Network"
row "net" "IPv4" "$ip_addr"

section "Top"
# show top 5 by MEM
if have ps; then
  printf "  %-10s │ %-14s │ %s\n" "proc" "PID CPU%% MEM%%" "Command"
  printf "  %s\n" "───────────┼────────────────┼────────────────────────────────"
  ps -o pid=,pcpu=,pmem=,comm= --sort=-%mem | head -n 5 | \
  while read -r pid pc pu cmd; do
    printf "  %-10s │ %-14s │ %s\n" "proc" "$pid $pc $pu" "$cmd"
  done
fi
