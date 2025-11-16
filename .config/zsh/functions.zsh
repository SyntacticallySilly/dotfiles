# ╔══════════════════════════════════════════════════════════════╗
# ║  Functions                                                    ║
# ║  Custom shell functions and utilities                        ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Yazi File Manager Integration
# ───────────────────────────────────────────────────────────────
# Change directory based on yazi's last location on exit
# Usage: y [path]
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

# Max history size for autocomplete.

