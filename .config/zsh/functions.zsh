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
  for archive in "$@"; do
    if [ -f "$archive" ]; then
      case $archive in
        *.tar.bz2) tar xvjf $archive ;;
        *.tar.gz) tar xvzf $archive ;;
        *.bz2) bunzip2 $archive ;;
        *.rar) rar x $archive ;;
        *.gz) gunzip $archive ;;
        *.tar) tar xvf $archive ;;
        *.tbz2) tar xvjf $archive ;;
        *.tgz) tar xvzf $archive ;;
        *.zip) unzip $archive ;;
        *.Z) uncompress $archive ;;
        *.7z) 7z x $archive ;;
        *) echo "don't know how to extract '$archive'..." ;;
      esac
    else
      echo "'$archive' is not a valid file!"
    fi
  done
}

# copy with progress.
cpp() {
  set -e
  strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
      count += $NF
      if (count % 10 == 0) {
        percent = count / total_size * 100
        printf "%3d%% [", percent
        for (i=0;i<=percent;i++)
          printf "="
          printf ">"
          for (i=percent;i<100;i++)
            printf " "
            printf "]\r"
          }
      }
  END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

up() {
  local d=""
  limit=$1
  for ((i = 1; i <= limit; i++)); do
    d=$d/..
  done
  d=$(echo $d | sed 's/^\///')
  if [ -z "$d" ]; then
    d=..
  fi
  cd $d
}
gcom() {
  git add .
  git commit -m "$1"
}
lazyg() {
  git add .
  git commit -m "$1"
  git push
}

function hb {
  if [ $# -eq 0 ]; then
    echo "No file path specified."
    return
  elif [ ! -f "$1" ]; then
    echo "File path does not exist."
    return
  fi

  uri="http://bin.christitus.com/documents"
  response=$(curl -s -X POST -d @"$1" "$uri")
  if [ $? -eq 0 ]; then
    hasteKey=$(echo $response | jq -r '.key')
    echo "http://bin.christitus.com/$hasteKey"
  else
    echo "Failed to upload the document."
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

pkgm() { local s=$(apt list 2>/dev/null | sort | fzf --style=full --color=dark --layout=default --height=80% --border --preview 'apt show {1} 2>/dev/null' --preview-window=down:50%); [[ -n "$s" ]] && { clear; pkg install "$(echo "$s" | awk -F'/' '{print $1}')"; } || clear; }
