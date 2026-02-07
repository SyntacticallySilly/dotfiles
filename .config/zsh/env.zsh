# ╔══════════════════════════════════════════════════════════════╗
# ║  Environment Variables                                        ║
# ║  Core environment setup and PATH configuration               ║
# ╚══════════════════════════════════════════════════════════════╝

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


# ───────────────────────────────────────────────────────────────
#  Editor Configuration
# ───────────────────────────────────────────────────────────────
# Set Neovim as default editor for all editing tasks
export EDITOR=nvim
export VISUAL=nvim
export PAGER=bat
export CLICOLOR=1
export BAT_STYLE="numbers,changes,header,grid"
export TITLE="%n@%m: %~"
export COMPLETION_WAITING_DOTS="true"
export TERMINAL="Terminal Ex"

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

export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"

# Ctrl-T: File search with bat preview
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"

# Alt-C: Directory navigation with ls preview
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

eval "$(dircolors -b)"  # GNU systems
# OR for BSD/macOS in Termux:
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
