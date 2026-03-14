# Syndot: Simple, Modern Termux Shell Setup

Syndot is a clean, fast shell setup for Termux on Android. It bundles Zsh, a nice prompt, smarter navigation, and a handful of quality-of-life tools so your terminal feels modern without being confusing.

This doc is written for normal humans. If you can open Termux and type commands, you’re good.

---

## What This Repo Contains

- Zsh configuration and plugins
- Zellij (terminal multiplexer) setup
- Termux settings (extra keys, fullscreen, cursor)
- Handy scripts (file organizer, theme switcher, Shizuku shell)
- App configs (Yazi, bat, glow, lazygit, etc.)

---

## Install / Update (What The Scripts Do)

### Install: `install.sh`

This script is **destructive** on purpose. It removes existing configs so Syndot can control your environment.

What it does:
- Deletes these paths if they exist: `~/.config`, `~/scripts`, `~/.termux`, `~/.zshrc`, `~/.bashrc`
- Runs `stow .` from `~/dotfiles` (symlinks all configs)
- Installs packages via `pkg install`
- Sets Zsh as your default shell
- Reloads Termux settings

Install command (from Termux home):

```bash
pkg install git stow && git clone https://github.com/SyntacticallySilly/dotfiles.git && bash ~/dotfiles/install.sh
```

### Update: `update.sh`

- Stashes local changes (if any)
- Pulls from `origin main`
- Re-stows configs
- Updates packages with `nala`
- Reloads shell + Termux

You can run:

```bash
zsh ~/dotfiles/update.sh
```

Or use the alias:

```bash
sysup
```

---

## Packages Installed

From `install.sh`:

- `zellij`, `starship`, `termux-tools`, `nala`, `tur-repo`, `zoxide`, `yazi`, `eza`, `fd`, `ripgrep`, `fzf`, `zsh`, `neofetch`, `neovim`, `chafa`, `man`, `stow`

---

## Shell (Zsh) Overview

Zsh is the main shell. It’s split into small config files in `~/.config/zsh/` and loaded by `~/.zshrc`.

### Prompt

- Uses **Starship** (`~/.config/starship.toml`)
- Also includes a **transient prompt** (a minimal prompt after you run a command)

### Plugins (via zinit)

Loaded in `~/.config/zsh/plugins.zsh`:

- `zsh-autocomplete` (live completions)
- `zsh-autosuggestions` (gray suggestions from history)
- `zsh-completions` (extra completions)
- `fast-syntax-highlighting` (colorized command line)
- `hlissner/zsh-autopair` (auto-closes quotes/brackets)
- `OMZP::catimg`, `OMZP::vi-mode`
- `zinit-annex-bin-gem-node`

### Key Bindings (most important)

- `,` accept autosuggestion
- `\` open completion menu
- `` ` `` forward word
- `!` history search backward
- `yy` in normal (vi) mode copies the current command to clipboard

### Handy Aliases

A few that matter most:

- `y` → Yazi file manager
- `l`, `lsf`, `lsd`, `lsa` → modern `ls` using `eza`
- `cd` → `z` (zoxide smart `cd`)
- `nv` → Neovim
- `refr` → reload Zsh + Termux
- `sysup` → update everything
- `orgdown` / `orgstats` → file organizer
- `themectl` → theme chooser
- `help` → open `syndot.md` in glow

You can see the full list in `~/.config/zsh/aliases.zsh`.

### Useful Functions

Defined in `~/.config/zsh/functions.zsh`:

- `mkcd <dir>`: make a folder and enter it
- `extract <file>`: unpack common archives
- `up <n>`: go up N directories
- `nvs`: fuzzy-open a file in Neovim
- `zs`: fuzzy jump to a zoxide directory
- `fkill`: fuzzy kill running processes
- `fman`: fuzzy open man pages
- `pkr`: fuzzy remove packages
- `fga`: fuzzy git add
- `fshare`: send a file via Android share sheet
- `applauncher`: pick and launch Android apps
- `fimg`: preview and open images

---

## Zellij (Terminal Multiplexer)
-- !> [!WARNING]
> highly experimental. dont use.

Zellij starts with a clean layout: top tabs + bottom status bar.

Important keys (from `~/.config/zellij/config.kdl`):

- `Tab` → enter “tmux” mode (like a leader key)
- `Tab` again (from locked) → unlock to normal

In **tmux mode** (after pressing `Tab`):

- `c` new tab
- `x` close tab
- `n` / `p` next/previous tab
- `:` split horizontal
- `{` split vertical
- `z` fullscreen
- `q` close pane
- `h/j/k/l` move focus
- `H/J/K/L` move pane

In **normal mode** (no leader):

- `Alt+h/j/k/l` move focus
- `Alt+H/J/K/L` resize panes
- `Alt+u/d` scroll
- `Alt+f` toggle pane frames
- `Alt+w` toggle floating panes
- `Alt+y` copy scrollback

---

## Termux Settings

Stored in `~/.termux/termux.properties`:

- Fullscreen enabled
- Extra keys row enabled (ESC, TAB, arrows, etc.)
- Cursor set to **block** and no blinking
- External apps allowed to run commands

There’s also a minimal floating layout in `~/.termux/termux.float.properties`.

---

## File Management

### Yazi

- Shows hidden files
- Sorts by modified time (newest first)
- Opens files with `termux-open`
- Uses plugins for borders, archive handling, and smart open

Config: `~/.config/yazi/yazi.toml`

### eza + fd + rg

- `eza` replaces `ls`
- `fd` is a fast file finder
- `rg` (ripgrep) is a fast search tool

---

## Custom Scripts

Scripts live in `~/scripts/` (symlinked from `~/dotfiles/scripts`).

- `file-organizer.sh`: sorts downloads into folders
  - `orgdown` → move files from Downloads
  - `orgstats` → show stats

- `theme-cycler.sh`: choose Termux themes with `fzf`
  - run: `themectl`

- `rish`: Shizuku shell helper (for elevated Android shell)

---

## Cheatsheet (Fast Reminders)

### Shell

- `refr` → reload Zsh + Termux
- `sysup` → update packages + dotfiles
- `nv` → open Neovim
- `y` → open Yazi
- `cd` (actually `z`) → smart jump
- `nvs` → fuzzy-open file in Neovim
- `zs` → fuzzy jump to a directory
- `fkill` → fuzzy kill process
- `fman` → fuzzy open man page

### File & Theme Scripts

- `orgdown` → sort Downloads into folders
- `orgstats` → show file stats
- `themectl` → pick a Termux theme

### Zellij

- `Tab` → enter tmux mode (leader)
- `Tab` (when locked) → unlock
- `Alt+h/j/k/l` → move focus
- `Alt+H/J/K/L` → resize
- `Alt+y` → copy scrollback

---

## Troubleshooting

- **Zsh not default?** Run: `chsh -s zsh`
- **Termux storage missing?** Run: `termux-setup-storage`
- **Zellij keys not working?** Make sure you’re not in locked mode. Press `Tab`.
- **Weird prompt?** Restart Termux or run `refr`.

---

## Related Doc

Neovim is documented in `synvim.md`.
