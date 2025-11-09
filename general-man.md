# Syndot General Manual

A comprehensive guide to the configuration, tools, and scripts in your Syndot dotfiles setup.

## Table of Contents

1.  [Introduction](#1-introduction)
2.  [Installation & Updates](#2-installation--updates)
    -   [Initial Setup (`install.sh`)](#initial-setup-installsh)
    -   [Updating (`update.sh`)](#updating-updatesh)
3.  [Shell Configuration (`.zshrc`)](#3-shell-configuration-zshrc)
    -   [Prompt (Oh My Posh)](#prompt-oh-my-posh)
    -   [Plugins (zinit)](#plugins-zinit)
    -   [Aliases](#aliases)
    -   [Keybindings](#keybindings)
    -   [Core Functions](#core-functions)
    -   [FZF Configuration](#fzf-configuration)
4.  [Terminal Multiplexer (Zellij)](#4-terminal-multiplexer-zellij)
    -   [Modal Keybindings](#modal-keybindings)
    -   [Common Actions](#common-actions)
5.  [File Manager (Yazi)](#5-file-manager-yazi)
6.  [Custom Scripts](#6-custom-scripts)
    -   [File Organizer](#file-organizer)
    -   [Boom Beautifier](#boom-beautifier)
7.  [Dependencies](#7-dependencies)

---

## 1. Introduction

This document details your personalized shell environment, built and managed by the Syndot dotfiles. The setup is centered around `zsh`, `neovim`, and various command-line tools designed to create an efficient and aesthetically pleasing experience on Termux.

The configuration is managed via `stow`, a symlink farm manager, which keeps the dotfiles organized in a central directory (`~/dotfiles`) while linking them to their correct locations in the home directory.

---

## 2. Installation & Updates

### Initial Setup (`install.sh`)

The `install.sh` script bootstraps the entire environment. It performs the following actions:

1.  **Displays a "SYNDOT" banner.**
2.  **Removes existing configurations**: It deletes `~/.config`, `~/scripts`, `~/.termux`, `~/.zshrc`, and `~/.bashrc` to ensure a clean installation.
3.  **Applies Dotfiles**: Runs `stow .` from within the `~/dotfiles` directory to symlink all the configurations into your home directory.
4.  **Installs Packages**: Uses `pkg` to install all essential command-line tools listed in the [Dependencies](#7-dependencies) section.
5.  **Reloads Session**: Sources the new `.zshrc` and reloads Termux settings to apply changes immediately.

### Updating (`update.sh`)

The `update.sh` script keeps your dotfiles and tools current.

1.  **Pulls Updates**: Fetches the latest changes from your `main` branch on GitHub. It automatically stashes any local modifications before pulling.
2.  **Re-applies Dotfiles**: Runs `stow --restow .` to apply any changes to the symlinked files.
3.  **Updates Packages**: Runs `pkg update && pkg upgrade` and ensures all essential packages are still installed.
4.  **Reloads Session**: Reloads the shell and Termux settings.

---

## 3. Shell Configuration (`.zshrc`)

Your shell is configured via the `.zshrc` file, which uses `zinit` to manage plugins.

### Prompt (Oh My Posh)

Your prompt is rendered by **Oh My Posh**, using the custom theme located at `~/.config/omp/zen.toml`.

A key feature is its integration with `vi-mode`. The prompt dynamically changes to indicate whether you are in **NORMAL** or **INSERT** mode, providing immediate visual feedback.

### Plugins (zinit)

The following plugins are loaded to enhance shell functionality:

| Plugin                                       | Description                                                              |
| -------------------------------------------- | ------------------------------------------------------------------------ |
| `marlonrichert/zsh-autocomplete`             | Provides real-time, IDE-like autocompletion as you type.                 |
| `zsh-users/zsh-autosuggestions`              | Suggests commands based on your history. Accept with `Ctrl + ,`.         |
| `zsh-users/zsh-completions`                  | Adds a vast collection of completion definitions for many commands.      |
| `hlissner/zsh-autopair`                      | Automatically closes quotes, brackets, and parentheses.                  |
| `zdharma-continuum/fast-syntax-highlighting` | Provides fast and accurate syntax highlighting for the command line.     |
| `sindresorhus/pretty-time-zsh`               | Converts `time` command output into a human-readable format.             |
| `oknowton/zsh-dwim`                          | "Do What I Mean" - attempts to fix command typos (e.g., `git comit`).    |
| `duggum/zeza`                                | Provides `eza` completions.                                              |
| `OMZP::colored-man-pages`                    | Adds color to `man` pages.                                               |
| `OMZP::command-not-found`                    | Suggests packages to install if a command is not found.                  |
| `OMZP::copypath`                             | Copies the absolute path of a file or directory to the clipboard.        |
| `OMZP::catimg`                               | Displays images in the terminal.                                         |
| `OMZP::vi-mode`                              | Adds Vi keybindings to the command line.                                 |

### Aliases

| Alias      | Command                                                  | Description                                                              |
| ---------- | -------------------------------------------------------- | ------------------------------------------------------------------------ |
| `n`        | `nnn -EHd`                                               | Opens the `nnn` file manager.                                            |
| `open`     | `termux-open`                                            | Opens a file using the appropriate Android app.                          |
| `fcd`      | `cd $(fd . --type d -H | fzf ...)`                       | Interactively find a directory with `fzf` and `cd` into it.              |
| `home`     | `cd ~`                                                   | Navigates to the home directory.                                         |
| `ls`       | `eza -a --no-quotes --icons=always`                      | Lists all files with icons.                                              |
| `lsf`      | `eza -a -f --icons=always --no-quotes`                   | Lists files without sorting.                                             |
| `lsd`      | `eza -a -DRT --level 2 --icons=always --no-quotes`       | Lists directories only, up to 2 levels deep.                             |
| `lsa`      | `eza -a --icons=always --tree --level=3 --no-quotes`     | Lists all files in a tree view, up to 3 levels deep.                     |
| `exs`      | `cd ~/storage/shared/`                                   | Navigates to the shared storage directory.                               |
| `refr`     | `source ~/.zshrc && termux-reload-settings && cd ~`      | Reloads shell, Termux settings, and returns home.                        |
| `nv`       | `nvim`                                                   | Opens Neovim.                                                            |
| `acp`      | `termux-clipboard-set <`                                 | Pipes command output into the Android clipboard.                         |
| `aps`      | `termux-clipboard-get >`                                 | Pastes Android clipboard content into a file or command.                 |
| `zadd`     | `zoxide add`                                             | Adds the current directory to `zoxide`'s database.                       |
| `zedit`    | `zoxide edit`                                            | (Likely a typo, `zoxide` has no `edit` command. Maybe `z query`?)        |
| `terstr`   | `sshd`                                                   | Starts the SSH server.                                                   |
| `killter`  | `pkill sshd`                                             | Stops the SSH server.                                                    |
| `organize` | `zsh ~/scripts/file-organizer.zsh`                       | Runs the file organizer script.                                          |
| `orgdown`  | `zsh ~/scripts/file-organizer.zsh organize`              | Alias to specifically organize the Downloads folder.                     |
| `orgstats` | `zsh ~/scripts/file-organizer.zsh stats`                 | Shows statistics for the Downloads folder.                               |
| `rish`     | `zsh ~/scripts/rish`                                     | Runs the `rish` script for Shizuku.                                      |

### Keybindings

| Key        | Action                  | Description                               | 
| ---------- | ----------------------- | ----------------------------------------- |
| `,`        | `autosuggest-accept`    | Accepts the current `zsh-autosuggestions` |
| `\`        | `menu-select`           | Selects an item from the completion menu. |
| `` ` ``    | `forward-word`          | Moves the cursor forward one word.        |
| `Alt+n`    | `history-search-forward`| Searches forward in history.              |
| `Alt+p`    | `history-search-backward`| Searches backward in history.             |

### Core Functions

-   **`y()`**: A wrapper for the `yazi` file manager. After you quit `yazi`, this function automatically changes the shell's directory to the last directory you were viewing in `yazi`.

### FZF Configuration

**FZF** is heavily customized for a better visual experience:
-   It uses a custom color scheme.
-   It uses `bat` to provide syntax-highlighted file previews.
-   `Ctrl+T` (file search) and `Alt+C` (directory search) are configured to use these previews.

---

## 4. Terminal Multiplexer (Zellij)

Your terminal multiplexer is **Zellij**, configured via `~/.config/zellij/config.kdl`. The configuration is modal, heavily inspired by Vim.

### Modal Keybindings

To perform actions, you first enter a mode by pressing a `Ctrl` key combination, and then you press a final key to execute the command.

| Mode     | Keybinding | Description                               |
| ---------- | ---------- | ----------------------------------------- |
| `Locked` | `Ctrl+g`   | Locks the session (all keys are ignored). |
| `Pane`   | `Ctrl+p`   | Commands for managing panes.              |
| `Tab`    | `Ctrl+t`   | Commands for managing tabs.               |
| `Resize` | `Ctrl+n`   | Commands for resizing panes.              |
| `Move`   | `Ctrl+h`   | Commands for moving panes.                |
| `Scroll` | `Ctrl+s`   | Commands for scrolling up and down.       |
| `Session`| `Ctrl+o`   | Commands for managing the session.        |

Press `Esc` at any time to return to **Normal** mode.

### Common Actions

-   **Create Pane**: `Ctrl+p`, then `d` (down) or `r` (right).
-   **Move Focus**: `Ctrl+p`, then `h/j/k/l` or arrow keys.
-   **Close Pane**: `Ctrl+p`, then `x`.
-   **Create Tab**: `Ctrl+t`, then `n`.
-   **Switch Tab**: `Ctrl+t`, then `h/l` or arrow keys.
-   **Close Tab**: `Ctrl+t`, then `x`.
-   **Go Fullscreen**: `Ctrl+p`, then `f`.
-   **Detach Session**: `Ctrl+o`, then `d`.
-   **Quit Zellij**: `Ctrl+q`.

---

## 5. File Manager (Yazi)

**Yazi** is a fast, terminal-based file manager.

-   It is launched using the `y` command (a function, not an alias). This special function ensures that when you exit Yazi, your shell's working directory is updated to the last directory you were in.
-   It is configured in `~/.config/yazi/yazi.toml` to use `termux-open` on Android, allowing you to open files in their respective Android applications directly from the terminal.

---

## 6. Custom Scripts

Your setup includes custom scripts located in the `~/scripts` directory.

### File Organizer

-   **Script**: `~/scripts/file-organizer.zsh`
-   **Description**: A powerful script to automatically sort files from a source directory (default: `~/storage/downloads`) into categorized subdirectories in a destination folder (default: `~/storage/shared/org`).
-   **Categories**: `images`, `documents`, `archives`, `videos`, `audio`, `code`, `data`, `packages`, `minecraft`, and `others`.
-   **Usage**:
    -   `organize` or `orgdown`: Moves files from Downloads to the organized folders.
    -   `orgstats`: Shows a statistical breakdown of file types in the Downloads folder.
    -   The script also accepts `copy`, `stats`, and `setup` commands for more control.

### Boom Beautifier

-   **Script**: `~/scripts/boom-beautifier.zsh`
-   **Description**: A user-friendly wrapper for the `apt` package manager in Termux. It provides colorful, interactive, and more informative output.
-   **Usage**:
    -   `boom install <pkg>`: Installs a package.
    -   `boom remove <pkg>`: Removes a package.
    -   `boom search`: Interactively search for packages using `fzf`.
    -   `boom update`: Updates package lists.
    -   `boom upgrade`: Upgrades all packages.
    -   `boom stats`: Shows package statistics (total installed, disk usage, etc.).

---

## 7. Dependencies

The `install.sh` script will automatically install the following packages:

-   `termux-tools`: Essential Termux utilities.
-   `zoxide`: A "smarter `cd` command" that remembers your most used directories.
-   `yazi`: A fast terminal file manager.
-   `eza`: A modern replacement for `ls`.
-   `fd`: A simple, fast, and user-friendly alternative to `find`.
-   `ripgrep`: A line-oriented search tool that recursively searches your current directory for a regex pattern.
-   `fzf`: A general-purpose command-line fuzzy finder.
-   `zsh`: The Z shell.
-   `neofetch`: A command-line system information tool.
-   `neovim`: A hyperextensible, Vim-based text editor.
-   `chafa`: A terminal graphics utility.
-   `man`: A manual page viewer.
