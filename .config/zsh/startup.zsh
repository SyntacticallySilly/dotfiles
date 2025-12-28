# ╔══════════════════════════════════════════════════════════════╗
# ║  Startup Actions                                              ║
# ║  Commands executed when interactive shell starts             ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  SSH Server Auto-Start
# ───────────────────────────────────────────────────────────────
# Silently start SSH server if not already running
# Useful for Mixplorer/remote file access
pgrep -x "sshd" > /dev/null || sshd

# ───────────────────────────────────────────────────────────────
#  Welcome Screen
# ───────────────────────────────────────────────────────────────
# Display neofetch system info in interactive shells only
if [[ -o interactive ]]; then
  command -v clear >/dev/null && clear
fi
