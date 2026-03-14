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
# eval "$(oh-my-posh init zsh --config ~/.config/omp/zen.toml)"

eval "$(starship init zsh)"

# ── Transient Prompt via --profile flag ──────────

autoload -Uz add-zsh-hook
add-zsh-hook precmd transient-prompt-precmd

TRANSIENT_PROMPT="${PROMPT// prompt / prompt --profile transient }"
TRANSIENT_RPROMPT="${PROMPT// prompt / prompt --profile rtransient }"

function transient-prompt-precmd {
    # Fix ctrl+c behavior
    TRAPINT() { transient-prompt; return $(( 128 + $1 )) }

    # Save transient prompt
    SAVED_PROMPT="$(eval "printf '%s' \"${TRANSIENT_PROMPT}\"")"
    SAVED_RPROMPT="$(eval "printf '%s' \"${TRANSIENT_RPROMPT}\"")"
}

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-finish transient-prompt

function transient-prompt() {
    # Use saved transient prompt
    PROMPT="$SAVED_PROMPT" RPROMPT="$SAVED_RPROMPT" zle .reset-prompt
}


autoload -Uz edit-command-line
zle -N edit-command-line
