# ╔══════════════════════════════════════════════════════════════╗
# ║  History Configuration                                        ║
# ║  Command history settings and behavior                       ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  History File Settings
# ───────────────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
HISTSIZE=2000        # Number of commands in memory
SAVEHIST=2000       # Number of commands saved to file

# ───────────────────────────────────────────────────────────────
#  History Options
# ───────────────────────────────────────────────────────────────
setopt INC_APPEND_HISTORY       # Append to history immediately (not on shell exit)
setopt HIST_IGNORE_DUPS         # Don't record duplicate consecutive commands
setopt HIST_IGNORE_SPACE        # Ignore commands starting with space
setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks from commands
setopt HIST_EXPIRE_DUPS_FIRST   # Expire duplicate entries first when trimming
