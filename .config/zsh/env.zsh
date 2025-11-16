# ╔══════════════════════════════════════════════════════════════╗
# ║  Environment Variables                                        ║
# ║  Core environment setup and PATH configuration               ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Editor Configuration
# ───────────────────────────────────────────────────────────────
# Set Neovim as default editor for all editing tasks
export EDITOR=nvim
export VISUAL=nvim

# ───────────────────────────────────────────────────────────────
#  PATH Configuration
# ───────────────────────────────────────────────────────────────
# Add user-local binaries to PATH (highest priority)
export PATH="${HOME}/.local/bin:${PATH}"

# ───────────────────────────────────────────────────────────────
#  FZF Configuration
# ───────────────────────────────────────────────────────────────
# Fuzzy finder with custom blue/purple theme and bat preview
export FZF_DEFAULT_OPTS="--style full --color='fg:#dbdbff,fg+:#dbdbff,bg+:#000000,hl:#0000ff,gutter:#000000,pointer:#0000ff,marker:#0000ff,header:#719872,spinner:#6d6dff,info:#dbdbff,prompt:#dbdbff,query:#dbdbff,border:#dbdbff' --smart-case --preview 'bat --color=always --style=numbers --line-range :500 {}' --height 80% --layout=reverse --border"

# Ctrl-T: File search with bat preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Alt-C: Directory navigation with ls preview
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
