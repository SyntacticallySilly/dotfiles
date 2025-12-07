# ╔══════════════════════════════════════════════════════════════╗
# ║  Functions                                                    ║
# ║  Custom shell functions and utilities                        ║
# ╚══════════════════════════════════════════════════════════════╝

# Create a directory and change into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Extract most common archive types
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

nvs() {
  local file=$(fzf --preview="bat --color=always --style=numbers {}")
  [[ -n "$file" ]] && nvim "$file"
}

function zs() {
  local selected=$(zoxide query -l | fzf \
    --prompt="cd to : " \
    --preview="eza -1 -aa --reverse --color=always --no-quotes --icons=always --git-repos-no-status {}" \
    --with-nth=-2,-1 \
    --delimiter=/)
  [[ -n "$selected" ]] && cd "$selected"
}
