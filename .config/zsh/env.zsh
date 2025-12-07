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
export PATH="$HOME/.cargo/bin:$PATH"

# ───────────────────────────────────────────────────────────────
#  FZF Configuration
# ───────────────────────────────────────────────────────────────
# Fuzzy finder with custom blue/purple theme and bat preview

# Ctrl-T: File search with bat preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Alt-C: Directory navigation with ls preview
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"
