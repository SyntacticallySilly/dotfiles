#!/bin/zsh

# Directory containing the theme files
THEMES_DIR="$HOME/dotfiles/.termux/themes"

# Check if fzf is installed
if ! command -v fzf &> /dev/null; then
    echo " Error: fzf is not installed. Please install it to use this script."
    exit 1
fi

# Check if the themes directory exists
if [ ! -d "$THEMES_DIR" ]; then
  echo " Error: Themes directory not found at $THEMES_DIR"
  exit 1
fi

# Get a list of theme files and extract the names
themes=($THEMES_DIR/*.theme)
theme_names=()
for theme in "${themes[@]}"; do
  theme_names+=("$(basename "$theme" .theme)")
done

# Check if there are any themes
if [ ${#theme_names[@]} -eq 0 ]; then
  echo " Error: No themes found in $THEMES_DIR"
  exit 1
fi

# Use fzf to select a theme
selected_theme_name=$(printf "%s\n" "${theme_names[@]}" | fzf --prompt="  Select a theme: " --preview-window=hidden)

# Exit if no theme was selected
if [ -z "$selected_theme_name" ]; then
  echo " No theme selected."
  exit 0
fi

# Find the corresponding theme file
selected_theme_file="$THEMES_DIR/$selected_theme_name.theme"

# Apply the new theme
if [ -f "$selected_theme_file" ]; then
  cp "$selected_theme_file" "$HOME/.termux/colors.properties"
  termux-reload-settings
  echo "  Theme set to: $selected_theme_name"
else
    echo " Error: Theme file not found for '$selected_theme_name'"
    exit 1
fi
