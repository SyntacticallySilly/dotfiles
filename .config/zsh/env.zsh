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

export DISPLAY=:0
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

# Add to .zshrc - generates basic LS_COLORS
eval "$(dircolors -b)"  # GNU systems
# # OR for BSD/macOS in Termux:
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
