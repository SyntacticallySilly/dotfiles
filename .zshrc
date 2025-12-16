# ╔══════════════════════════════════════════════════════════════╗
# ║  ZSH Configuration - Main Entry Point                        ║
# ║  Location: ~/.zshrc                                          ║
# ║  Author: Your Name                                           ║
# ║  Device: Samsung A22 5G - Termux Environment                 ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Module Loading Order (Performance Optimized)
# ───────────────────────────────────────────────────────────────
# Load order matters for performance and functionality:
# 1. Environment variables (early initialization)
# 2. Zinit bootstrap (plugin manager setup)
# 3. Plugins (core functionality - autocomplete first)
# 4. Completions & styles (after plugins loaded)
# 5. Binds (user interaction)
# 6. Aliases (command shortcuts)
# 7. Functions (custom utilities)
# 8. External tools (zoxide, oh-my-posh)
# 9. Welcome screen (visual feedback)

source ~/dotfiles/.config/zsh/env.zsh
source ~/dotfiles/.config/zsh/history.zsh
source ~/dotfiles/.config/zsh/zinit-bootstrap.zsh
source ~/dotfiles/.config/zsh/external-tools.zsh
source ~/dotfiles/.config/zsh/functions.zsh
source ~/dotfiles/.config/zsh/plugins.zsh
source ~/dotfiles/.config/zsh/completions.zsh
source ~/dotfiles/.config/zsh/binds.zsh
source ~/dotfiles/.config/zsh/vi-mode.zsh
source ~/dotfiles/.config/zsh/aliases.zsh
source ~/dotfiles/.config/zsh/startup.zsh

# ───────────────────────────────────────────────────────────────
#  End of Configuration
# ───────────────────────────────────────────────────────────────
