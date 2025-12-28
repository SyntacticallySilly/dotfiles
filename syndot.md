# Syndot: The Comprehensive Guide

Welcome to the official documentation for Syndot, an opinionated and performance-focused dotfiles setup tailored for the Termux environment on Android. This guide will walk you through the installation, configuration, and usage of the various components that make up this powerful command-line experience.

## Table of Contents

1.  [Introduction](#1-introduction)
2.  [Installation & Updates](#2-installation--updates)
    -   [Initial Setup (`install.sh`)](#initial-setup-installsh)
    -   [Updating (`update.sh`)](#updating-updatesh)
3.  [Shell Configuration (Zsh)](#3-shell-configuration-zsh)
    -   [The Prompt (Oh My Posh)](#the-prompt-oh-my-posh)
    -   [Plugins (zinit)](#plugins-zinit)
    -   [Aliases](#aliases)
    -   [Keybindings](#keybindings)
    -   [Core Functions](#core-functions)
    -   [FZF Configuration](#fzf-configuration)
4.  [Terminal Multiplexer (Zellij)](#4-terminal-multiplexer-zellij)
    -   [Modal Keybindings](#modal-keybindings)
    -   [Common Actions](#common-actions)
5.  [File Management](#5-file-management)
    -   [Yazi File Manager](#yazi-file-manager)
    -   [eza (ls replacement)](#eza-ls-replacement)
6.  [Custom Scripts](#6-custom-scripts)
    -   [File Organizer](#file-organizer)
    -   [Theme Cycler](#theme-cycler)
    -   [Rish (Shizuku)](#rish-shizuku)
7.  [Core Dependencies](#7-core-dependencies)

---

## 1. Introduction

Syndot is designed to provide a modern, efficient, and visually appealing command-line environment on Android devices using Termux. It leverages a curated set of tools, a powerful Zsh configuration, and a highly customized Neovim setup (documented separately in [Synvim.md](synvim.md)).

The entire configuration is managed using `stow`, a symlink farm manager, which keeps the dotfiles neatly organized in a central `~/dotfiles` directory while ensuring they are correctly placed in your home directory.

---

## 2. Installation & Updates

### Initial Setup (`install.sh`)

The `install.sh` script is your one-stop shop for bootstrapping the entire Syndot environment. It automates the following steps:

1.  **Displays a "SYNDOT" banner.**
2.  **Cleans Existing Configurations**: To prevent conflicts, it removes any existing `~/.config`, `~/scripts`, `~/.termux`, `~/.zshrc`, and `~/.bashrc` files and directories.
3.  **Applies Dotfiles**: It runs `stow .` from within the `~/dotfiles` directory, which creates symlinks for all the configuration files to their correct locations.
4.  **Installs Packages**: It uses `pkg` (via `nala`) to install all the essential command-line tools required for the setup to function correctly.
5.  **Sets Zsh as Default**: The script changes the default shell to Zsh.
6.  **Reloads Session**: Finally, it sources the new `.zshrc` and reloads Termux settings to apply all changes immediately.

To install, run the following command in your Termux home directory:
```bash
pkg install git stow && git clone https://github.com/SyntacticallySilly/dotfiles.git && bash ~/dotfiles/install.sh
```

### Updating (`update.sh`)

The `update.sh` script is designed to keep your Syndot setup up-to-date with the latest changes from the Git repository and system packages.

-   **Pulls Git Updates**: Fetches the latest changes from the `main` branch of your dotfiles repository. It automatically stashes any local modifications before pulling to avoid conflicts.
-   **Re-applies Dotfiles**: Runs `stow --restow .` to ensure any new or modified files are correctly symlinked.
-   **Updates System Packages**: It runs `nala update` and `nala upgrade` to keep all your Termux packages current.
-   **Reloads Session**: Reloads the shell and Termux settings to apply the updates.

You can run this script at any time by simply executing `update.sh` or using the `sysup` alias.

---

## 3. Shell Configuration (Zsh)

The heart of Syndot is its Zsh configuration, which is modularly structured and loaded via `~/.zshrc`. It uses `zinit` for efficient plugin management.

### The Prompt (Oh My Posh)

Your command prompt is rendered by **Oh My Posh**, using a custom theme defined in `~/.config/omp/zen.toml`.

A key feature of this prompt is its seamless integration with Zsh's `vi-mode`. The prompt dynamically changes to indicate whether you are in **NORMAL** or **INSERT** mode, providing immediate visual feedback on your current editing state.

### Plugins (zinit)

Syndot uses `zinit` to load a variety of plugins that enhance shell functionality:

| Plugin | Description |
|---|---|
| `marlonrichert/zsh-autocomplete` | Provides real-time, IDE-like autocompletion as you type. |
| `zsh-users/zsh-autosuggestions` | Suggests commands based on your history. Accept with `,`. |
| `Aloxaf/fzf-tab` | Replaces the standard completion menu with `fzf`. |
| `zsh-users/zsh-completions` | Adds a vast collection of completion definitions for many commands. |
| `hlissner/zsh-autopair` | Automatically closes quotes, brackets, and parentheses. |
| `zdharma-continuum/fast-syntax-highlighting` | Provides fast and accurate syntax highlighting for the command line. |
| `oknowton/zsh-dwim` | "Do What I Mean" - attempts to fix command typos (e.g., `git comit`). |
| `duggum/zeza` | Provides `eza` completions and custom color configurations. |
| `OMZP::colored-man-pages` | Adds color to `man` pages for better readability. |
| `OMZP::command-not-found` | Suggests packages to install if a command is not found. |
| `OMZP::copypath` | Copies the absolute path of a file or directory to the clipboard. |
| `OMZP::catimg` | A utility to display images directly in the terminal. |
| `OMZP::vi-mode` | Adds Vi keybindings and indicators to the command line. |

### Aliases

A rich set of aliases is provided to streamline common tasks:

| Alias | Command | Description |
|---|---|---|
| `n` | `nnn -EHd` | Opens the `nnn` file manager. |
| `ls`, `lsf`, `lsd`, `lsa` | `eza ...` | A set of aliases for the modern `ls` replacement, `eza`. |
| `fcd` | `z $(fd . --type d -H \| fzf ...)` | Interactively find a directory with `fzf` and `cd` into it. |
| `home` | `z ~` | Navigates to the home directory using `zoxide`. |
| `exs` | `z ~/storage/shared/` | Jumps to the shared storage directory. |
| `nv` | `nvim` | A quick shortcut to launch Neovim. |
| `refr` | `source ~/.zshrc && termux-reload-settings && cd ~` | Reloads the shell, Termux settings, and returns home. |
| `acp` | `termux-clipboard-set <` | Pipes command output into the Android clipboard. |
| `aps` | `termux-clipboard-get >` | Pastes Android clipboard content into a file or command. |
| `sysup` | `nala update && nala upgrade && ...` | A comprehensive system update command. |
| `terstr` / `killter` | `sshd` / `pkill sshd` | Starts and stops the SSH server. |
| `organize`, `orgdown`, `orgstats` | `zsh .../file-organizer.zsh ...` | Shortcuts for the file organizer script. |
| `themesctl` | `zsh .../theme-cycler.sh` | Launches the interactive theme cycler. |
| `rish` | `zsh ~/scripts/rish` | Runs the `rish` script for Shizuku remote shell access. |

### Keybindings

-   `,` : Accept the current `zsh-autosuggestions`.
-   `\` : Select an item from the completion menu.
-   `` ` `` : Move the cursor forward one word.
-   `^[n` / `^[p` : Search forward and backward in history.

### FZF Configuration

**FZF** is configured with a custom theme and uses `bat` to provide syntax-highlighted file previews, making file and directory searches more informative.

---

## 4. Terminal Multiplexer (Zellij)

**Zellij** is the terminal multiplexer of choice, configured via `~/.config/zellij/config.kdl`. The configuration is modal and heavily optimized for a mobile-first, touch-friendly experience.

### Modal Keybindings

To avoid key collisions with other terminal applications, Zellij starts in `locked` mode.

-   **Enter Normal Mode**: Press `Ctrl+g` or `Alt+g`.
-   **Return to Locked Mode**: Press `Esc` from any other mode.

Once in `normal` mode, you can switch to other modes:

| Mode | Key | Description |
|---|---|---|
| `Pane` | `p` | Commands for managing panes. |
| `Tab` | `t` | Commands for managing tabs. |
| `Resize` | `r` | Commands for resizing panes. |
| `Scroll` | `s` | Commands for scrolling up and down. |
| `Move` | `m` | Commands for moving panes. |

### Common Actions

-   **Create Pane**: `p`, then `h` (left), `j` (down), `k` (up), or `l` (right).
-   **Move Focus**: In `normal` mode, use arrow keys.
-   **Close Pane**: `x` in `normal` mode.
-   **Create Tab**: `t`, then `n`.
-   **Switch Tab**: `t`, then `h` (previous) or `l` (next).
-   **Go Fullscreen**: `z` in `normal` mode.
-   **Quit Zellij**: `q` in `normal` mode.

---

## 5. File Management

### Yazi File Manager

**Yazi** is a fast, terminal-based file manager with a clean interface.

-   **Launch**: Use the `y` command. This special function ensures that when you exit Yazi, your shell's working directory is updated to the last directory you were in.
-   **Android Integration**: It is configured in `~/.config/yazi/yazi.toml` to use `termux-open`, allowing you to open files in their respective Android applications directly from the terminal.
-   **Theme**: It uses the Catppuccin Mocha theme for a consistent look and feel.

### eza (ls replacement)

**eza** is a modern replacement for the `ls` command, providing better defaults, more features, and icon support. The `ls`, `lsf`, `lsd`, and `lsa` aliases are all configured to use `eza` with different options for file, directory, and tree views.

---

## 6. Custom Scripts

Syndot includes several custom scripts located in the `~/scripts` directory to automate common tasks.

### File Organizer

-   **Script**: `~/scripts/file-organizer.zsh`
-   **Description**: A powerful script to automatically sort files from a source directory (default: `~/storage/downloads`) into categorized subdirectories in a destination folder (default: `~/storage/shared/org`).
-   **Usage**:
    -   `organize` or `orgdown`: Moves files from Downloads to the organized folders.
    -   `orgstats`: Shows a statistical breakdown of file types in the Downloads folder.

### Theme Cycler

-   **Script**: `~/scripts/theme-cycler.sh`
-   **Description**: An interactive script that allows you to switch your Termux color scheme on the fly. It uses `fzf` to present a list of available themes.
-   **Usage**: Run `themesctl` to launch the theme selector.

### Rish (Shizuku)

-   **Script**: `~/scripts/rish`
-   **Description**: A script to launch a remote shell with elevated privileges using Shizuku. This is useful for advanced Android system management.
-   **Usage**: Run `rish`.

---

## 7. Core Dependencies

The `install.sh` script will automatically install the following essential packages:

-   `termux-tools`: Core Termux utilities.
-   `nala`: A prettier front-end for the `apt` package manager.
-   `zoxide`: A "smarter `cd` command" that remembers your most used directories.
-   `yazi`: A fast terminal file manager.
-   `eza`: A modern replacement for `ls`.
-   `fd`: A simple, fast, and user-friendly alternative to `find`.
-   `ripgrep`: A line-oriented search tool that recursively searches for a regex pattern.
-   `fzf`: A general-purpose command-line fuzzy finder.
-   `zsh`: The Z shell.
-   `neofetch` & `fastfetch`: Command-line system information tools.
-   `neovim`: A hyperextensible, Vim-based text editor.
-   `chafa`: A terminal graphics utility for image previews.
-   `man`: A manual page viewer.
-   `stow`: A symlink farm manager for managing dotfiles.
