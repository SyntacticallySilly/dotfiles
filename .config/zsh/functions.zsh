# ╔══════════════════════════════════════════════════════════════╗
# ║  Functions                                                    ║
# ║  Custom shell functions and utilities                        ║
# ╚══════════════════════════════════════════════════════════════╝

# Create a directory and change into it
mkcd() {
  mkdir -p "$1" && cd "$1"
}

# Different compdump path inside Zellij to avoid cache conflicts
if [[ -n "$ZELLIJ" ]]; then
  export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-zellij-${ZSH_VERSION}"
else
  export ZSH_COMPDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${ZSH_VERSION}"
fi

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

function fkill() {
  local pid=$(ps -eo pid,comm | sed 1d | fzf --multi \
    --prompt="kill process : " \
    --with-nth=2.. \
    --preview="ps -p {1} -o pid,ppid,user,%cpu,%mem,start,command" \
    --preview-window=up:3:wrap | awk '{print $1}')
  [[ -n "$pid" ]] && echo "$pid" | xargs kill -9
}

function fman() {
  local selected=$(man -k . | \
    fzf --prompt="man : " \
    --with-nth=1 \
    --delimiter=' ' \
    --preview="echo {} | awk '{print $1}' | tr -d '()' | xargs man 2>/dev/null" \
    --preview-window=right:70%)
  if [[ -n "$selected" ]]; then
    local cmd=$(echo "$selected" | awk '{print $1}')
    man "$cmd"
  fi
}

function pkr() {
  dpkg --get-selections | awk '{print $1}' | fzf --multi \
    --prompt="remove : " \
    --preview="nala show {}" \
    --preview-window=right:60% | xargs -r nala remove -y
  }

function fga() {
  git status --short | fzf --multi --ansi \
    --prompt="stage : " \
    --preview="git diff --color=always {2}" \
    --preview-window=right:70% | \
    awk '{print $2}' | xargs -r git add
  }

fshare() {
  local selected_file

  # Use fzf to select a file with preview explicitly disabled
  selected_file=$(find . -maxdepth 1 -type f | sed 's|^./||' | fzf --preview-window=hidden --prompt="Select file to share: ")

  # Check if a file was selected
  if [[ -n "$selected_file" ]]; then
    termux-share "$selected_file"
    echo "Shared: $selected_file"
  else
    echo "No file selected"
    return 1
  fi
}


applauncher() {
  local selection package_name app_list

  # Create a temporary list of apps with their labels
  app_list=$(mktemp)

  echo "Loading apps..."
  cmd package list packages -3 | sed 's/package://' | while read -r pkg; do
  # Get APK path
  apk_path=$(cmd package path "$pkg" 2>/dev/null | head -n1 | cut -d':' -f2 | tr -d '
  ')

  if [[ -n "$apk_path" ]]; then
    # Extract app label using aapt
    app_name=$(aapt dump badging "$apk_path" 2>/dev/null | grep -oP "application-label:'K[^']+")

    # Fallback to package name if label extraction fails
    if [[ -z "$app_name" ]]; then
      app_name="$pkg"
    fi

    echo "$app_name|$pkg"
  fi
done | sort > "$app_list"

# Use fzf to select app
selection=$(cat "$app_list" | fzf --no-preview --delimiter='|' --with-nth=1 --prompt="Launch app: " --height=40%)

if [[ -n "$selection" ]]; then
  # Extract package name from selection
  package_name=$(echo "$selection" | cut -d'|' -f2)
  app_name=$(echo "$selection" | cut -d'|' -f1)

  # Launch the app
  am start --user 0 "$package_name" > /dev/null 2>&1
  if [[ $? -eq 0 ]]; then
    echo "✓ Launched: $app_name"
  else
    echo "✗ Failed to launch: $app_name"
    rm "$app_list"
    return 1
  fi
else
  echo "No app selected"
fi

rm "$app_list"
}

fimg() {
  local selected
  selected=$(find . -type f ( \
    -iname "*.png" -o \
    -iname "*.jpg" -o \
    -iname "*.jpeg" -o \
    -iname "*.gif" -o \
    -iname "*.bmp" -o \
    -iname "*.svg" -o \
    -iname "*.webp" -o \
    -iname "*.tiff" -o \
    -iname "*.tif" -o \
    -iname "*.ico" \
    ) 2>/dev/null | \
    fzf --preview 'chafa -f symbols -s $FZF_PREVIEW_COLUMNS {}' \
    --preview-window='right:60%' \
    --height=100% \
    --border)

  [[ -n "$selected" ]] && termux-open "$selected"
}

tere() {
  local result=$(command tere "$@")
  [ -n "$result" ] && cd -- "$result"
}

function copy-buffer-to-clipboard() {
  echo -n "$BUFFER" | termux-clipboard-set
  zle -M "Copied to clipboard"
}
zle -N copy-buffer-to-clipboard
