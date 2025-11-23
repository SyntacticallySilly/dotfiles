# ╔══════════════════════════════════════════════════════════════╗
# ║  External Tools                                               ║
# ║  Third-party CLI tool initialization                         ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Zoxide (Smart Directory Jumper)
# ───────────────────────────────────────────────────────────────
# Initialize zoxide for 'z' command (tracks frequently used dirs)
eval "$(zoxide init zsh)"

# ───────────────────────────────────────────────────────────────
#  Oh My Posh (Prompt Theme)
# ───────────────────────────────────────────────────────────────
# Load custom prompt configuration from zen.toml
eval "$(oh-my-posh init zsh --config ~/.config/omp/zen.toml)"

# ───────────────────────────────────────────────────────────────
#  Zsh-Notify Configuration
# ───────────────────────────────────────────────────────────────
# Set the title for notifications sent by zsh-notify
# export ZSH_NOTIFY_TITLE="Termux Shell"
