# ╔══════════════════════════════════════════════════════════════╗
# ║  Functions                                                    ║
# ║  Custom shell functions and utilities                        ║
# ╚══════════════════════════════════════════════════════════════╝
# In ~/.zshrc (Termux)
y() {
  local tmp="$(mktemp -t 'yazi-cwd.XXXXXX')" cwd
    yazi "$@" --cwd-file="$tmp"
      if cwd="$(cat -- "$tmp" 2>/dev/null)" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          cd -- "$cwd"
            fi
              rm -f -- "$tmp"
              }

