# ╔══════════════════════════════════════════════════════════════╗
# ║  Aliases                                                      ║
# ║  Command shortcuts and common operations                     ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  File Management
# ───────────────────────────────────────────────────────────────
# nnn: File manager with extended options, hidden files, detail view
alias n='nnn -EHd'

# eza: Modern ls replacement with icons
alias ls='eza -aa --no-quotes --icons=always'
alias lsf='eza -a -f --icons=always --no-quotes'          # Files only
alias lsd='eza -a -DRTl --level 2 --icons=always --no-quotes'  # Dirs (tree, level 2)
alias lsa='eza -a --icons=always --tree --level=3 --no-quotes'  # All (tree, level 3)

# ───────────────────────────────────────────────────────────────
#  Navigation
# ───────────────────────────────────────────────────────────────
# fcd: Fuzzy find and change directory
alias fcd='z $(fd . --type d -H | fzf --no-preview --height 70%)'

# Quick jump to home directory
alias home='z ~'

# Access Termux shared storage
alias exs='z ~/storage/shared/'

# ───────────────────────────────────────────────────────────────
#  Zoxide Integration
# ───────────────────────────────────────────────────────────────
alias zadd="zoxide add"
alias zedit="zoxide edit"

# ───────────────────────────────────────────────────────────────
#  Editor
# ───────────────────────────────────────────────────────────────
# Quick Neovim launch
alias nv='nvim'

# ───────────────────────────────────────────────────────────────
#  System Operations
# ───────────────────────────────────────────────────────────────
# Reload Zsh configuration and return to home
alias refr='source ~/.zshrc && termux-reload-settings && cd ~'

# Termux-specific utilities
alias open='termux-open'
alias acp="termux-clipboard-set <"   # Copy file to clipboard
alias aps="termux-clipboard-get >"   # Paste clipboard to file
alias sysup="nala update -y && nala upgrade -y && zinit update && zsh ~/dotfiles/update.sh && source ~/.zshrc && termux-reload-settings"
# ───────────────────────────────────────────────────────────────
#  SSH Server Management
# ───────────────────────────────────────────────────────────────
alias terstr="sshd"          # Start SSH server
alias killter="pkill sshd"   # Stop SSH server

# ───────────────────────────────────────────────────────────────
#  Custom Scripts
# ───────────────────────────────────────────────────────────────
# File organizer script
alias organize='zsh ~/dotfiles/scripts/file-organizer.zsh'
alias orgdown='zsh ~/dotfiles/scripts/file-organizer.zsh organize'
alias orgstats='zsh ~/dotfiles/scripts/file-organizer.zsh stats'

# Theme cycler.
alias themesctl='zsh ~/dotfiles/scripts/theme-cycler.sh'

# Shizuku remote shell
alias rish='zsh ~/scripts/rish'
