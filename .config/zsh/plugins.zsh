# ╔══════════════════════════════════════════════════════════════╗
# ║  Plugin Configuration                                         ║
# ║  Third-party plugins loaded via Zinit                        ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Core Plugins (Load Order Critical)
# ───────────────────────────────────────────────────────────────
# zsh-autocomplete MUST load first - manages compinit internally
zinit light marlonrichert/zsh-autocomplete

# Autosuggestions - suggests commands based on history
zinit light zsh-users/zsh-autosuggestions

# Fzf tab completipn.
zinit light Aloxaf/fzf-tab

# Additional completions for common commands
zinit light zsh-users/zsh-completions

# Auto-close brackets, quotes, etc.
zinit light hlissner/zsh-autopair

# Syntax highlighting (load late for performance)
zinit light zdharma-continuum/fast-syntax-highlighting

# ───────────────────────────────────────────────────────────────
#  Utility Plugins
# ───────────────────────────────────────────────────────────────
# Pretty time display for command duration
# zinit light sindresorhus/pretty-time-zsh

# Smart command line expansion (Do What I Mean)
zinit light oknowton/zsh-dwim

# Enhanced eza integration
zinit light duggum/zeza
#
# # ───────────────────────────────────────────────────────────────
# #  Oh My Zsh Plugins (Loaded as Snippets)
# # ───────────────────────────────────────────────────────────────
# zinit snippet OMZP::*
# Colorized man pages
zinit snippet OMZP::colored-man-pages

# Suggests package installation for unknown commands
zinit snippet OMZP::command-not-found

# Copy current directory path to clipboard
zinit snippet OMZP::copypath

# Display images in terminal (catimg command)
zinit snippet OMZP::catimg

# Vi-mode support (keybindings and indicators)
zinit snippet OMZP::vi-mode

zinit snippet OMZP::zinit

# # ───────────────────────────────────────────────────────────────
# #  Appearance & Feedback Plugins
# # ───────────────────────────────────────────────────────────────
# # Colorize output of various commands
# zinit light zdharma-continuum/zsh-colorize
zinit load zdharma-continuum/zsh-colorize

# Use bat for man pages and other previews (requires bat)
zinit light knu/zsh-bat

# Notifications for long-running commands (uses termux-notification)
zinit light marzocchi/zsh-notify

# Gentle reminders to use aliases you have defined
zinit light MichaelAquilina/zsh-you-should-use

# YouTube-DL/yt-dlp integration with fzf for searching
zinit snippet OMZP::yt-dlp
