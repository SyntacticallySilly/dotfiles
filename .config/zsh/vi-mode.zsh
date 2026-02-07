# ╔══════════════════════════════════════════════════════════════╗
# ║  Vi Mode Integration                                          ║
# ║  Vi mode indicator for Oh My Posh prompt                     ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Vi-Mode Plugin Configuration
# ───────────────────────────────────────────────────────────────
# Reset prompt when switching between insert/normal mode
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

# Suppress plugin's default right prompt indicator
RPROMPT=''

# ───────────────────────────────────────────────────────────────
#  Cursor Shape Configuration
# ───────────────────────────────────────────────────────────────
# Enable cursor shape changes based on mode
export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_NORMAL=2  # Block cursor in normal mode
export VI_MODE_CURSOR_VISUAL=6  # Line cursor in visual mode
export VI_MODE_CURSOR_INSERT=3  # Beam cursor in insert mode

# ───────────────────────────────────────────────────────────────
#  Oh My Posh Integration
# ───────────────────────────────────────────────────────────────
# Export POSH_VI_MODE variable for prompt display

# Helper function to redraw prompt (respects precmd hooks)
_omp_redraw_prompt() {
  local f
  for f in "${precmd_functions[@]}"; do "$f"; done
  zle .reset-prompt
}

# Update POSH_VI_MODE on keymap changes and repaint prompt
function _omp_zle-keymap-select() {
  if [[ "${KEYMAP}" == vicmd ]]; then
    export POSH_VI_MODE="NORMAL"
  else
    export POSH_VI_MODE="INSERT"
  fi
  _omp_redraw_prompt
}
zle -N _omp_zle-keymap-select
zle -N zle-keymap-select _omp_zle-keymap-select

# Reset to INSERT mode after command execution or Ctrl-C
function _omp_zle-line-finish() {
  export POSH_VI_MODE="INSERT"
}
zle -N _omp_zle-line-finish
zle -N zle-line-finish _omp_zle-line-finish

# Set default mode on shell startup
export POSH_VI_MODE="INSERT"
