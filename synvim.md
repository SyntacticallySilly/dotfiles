# SynVim: A Neovim Configuration Manual

Welcome to the comprehensive guide for your custom Neovim setup, **SynVim**. This document details the core settings, keybindings, installed plugins, and theming capabilities of your performance-focused configuration for Termux.

## Table of Contents

1.  [Core Concepts](#1-core-concepts)
2.  [Core Editor Settings](#2-core-editor-settings)
3.  [Keymaps](#3-keymaps)
    -   [Leader Key](#leader-key)
    -   [General Navigation & Editing](#general-navigation--editing)
    -   [Search (`<leader>s`)](#search-leaders)
    -   [Harpoon (`<leader>h`)](#harpoon-leaderh)
    -   [Git (`<leader>g`)](#git-leaderg)
    -   [Diagnostics (`<leader>x`)](#diagnostics-leaderx)
    -   [Formatting (`<leader>f`)](#formatting-leaderf)
    -   [Other Plugin Keymaps](#other-plugin-keymaps)
4.  [Installed Plugins](#4-installed-plugins)
    -   [UI & Appearance](#ui--appearance)
    -   [Editing & Text Manipulation](#editing--text-manipulation)
    -   [Completion & LSP](#completion--lsp)
    -   [Navigation & Fuzzy Finding](#navigation--fuzzy-finding)
    -   [Git Integration](#git-integration)
    -   [Utility](#utility)
5.  [Themes](#5-themes)
    -   [Available Themes](#available-themes)
    -   [Switching Themes](#switching-themes)

---

## 1. Core Concepts

-   **Performance First**: The configuration is optimized for speed on Termux by disabling unused default plugins and lazy-loading most plugins.
-   **Modal UI**: The setup relies on plugins like `which-key.nvim` and a logical keymap structure to be easily discoverable.
-   **Lazy Loading**: Plugins are loaded "lazily" (i.e., only when they are needed) by `lazy.nvim`, which dramatically improves startup time.
-   **Action-First Keymaps**: Keymaps are organized by action. For example, all "Search" actions are prefixed with `<leader>s`, and all "Git" actions with `<leader>g`.

---

## 2. Core Editor Settings

Your editor's behavior is defined in `lua/synvim/settings.lua`.

| Setting                | Value                               | Description                                                  |
| ---------------------- | ----------------------------------- | ------------------------------------------------------------ |
| **Leader Key**         | `Space`                             | The primary key for custom commands.                         |
| **Indentation**        | `2` spaces                          | Tabs are expanded to 2 spaces.                               |
| **Line Numbers**       | `relative`                          | Shows the current line number and relative numbers for others. |
| **Wrapping**           | `disabled`                          | Long lines will not wrap.                                    |
| **Search**             | `case-insensitive` (smart)          | Search is case-insensitive unless an uppercase letter is used. |
| **Undo**               | `persistent`                        | Undo history is saved between sessions.                      |
| **Clipboard**          | `sync on yank`                      | Yanking (`y`) copies to the system clipboard. Deleting (`d`) does not. |
| **Cursor**             | `highlight line`                    | The current line is highlighted.                             |
| **Scrolling Offset**   | `8` lines                           | Keeps 8 lines visible above/below the cursor when scrolling. |
| **Update Time**        | `200ms`                             | Reduces delay for events like cursor hold.                   |
| **Timeout Length**     | `300ms`                             | Reduces delay for multi-key commands (e.g., `<leader>s`).    |

---

## 3. Keymaps

Keymaps are defined in `lua/synvim/keymaps.lua` and within individual plugin files.

### Leader Key

The leader key is ` ` (Space).

### General Navigation & Editing

| Keymap      | Mode(s) | Action                               |
| ----------- | ------- | ------------------------------------ |
| `jk`        | Insert  | Exit Insert Mode                     |
| `<C-h/j/k/l>` | Normal  | Move between window splits           |
| `<C-Up/Down>` | Normal  | Increase/Decrease window height      |
| `<C-Left/Right>`| Normal  | Increase/Decrease window width       |
| `<A-j/k>`   | Normal, Insert, Visual | Move current line/selection up/down  |
| `>` / `<`   | Visual  | Indent/Un-indent selection           |
| `s`         | Normal, Visual | Jump to any character (`flash.nvim`) |
| `S`         | Normal, Visual | Jump to any Treesitter node (`flash.nvim`) |
| `y`         | Normal, Visual | Yank to buffer (and system clipboard) |
| `p` / `P`   | Normal, Visual | Paste after/before from yank history |
| `<c-p>` / `<c-n>` | Normal | Cycle through yank history |

### Search (`<leader>s`)

Powered by `telescope.nvim`.

| Keymap      | Action                       |
| ----------- | ---------------------------- |
| `<leader>sf`| Search **F**iles             |
| `<leader>sg`| Search **G**rep (Live Grep)  |
| `<leader>sb`| Search **B**uffers           |
| `<leader>sh`| Search **H**elp Tags         |
| `<leader>sr`| Search **R**ecent Files      |
| `<leader>ss`| **S**earch in Current Buffer |
| `<leader>sw`| Search **W**ord Under Cursor |
| `<leader>sk`| Search **K**eymaps           |
| `<leader>sc`| Search **C**onfig Files      |
| `<leader>sd`| Search **D**iagnostics       |
| `<leader>sq`| Search **Q**uickfix History  |
| `<leader>sy`| Search **Y**ank History      |
| `<leader>st`| Search **T**ODO Comments     |

### Harpoon (`<leader>h`)

Powered by `harpoon`. Used for quick file navigation.

| Keymap       | Action                     |
| ------------ | -------------------------- |
| `<leader>ha` | **A**dd file to Harpoon    |
| `<leader>he` | **E**dit Harpoon marks (UI)|
| `<leader>h1-4`| Jump to mark 1-4           |

### Git (`<leader>g`)

Powered by `gitsigns.nvim`.

| Keymap      | Action                     |
| ----------- | -------------------------- |
| `]h` / `[h`  | Next/Previous Git Hunk     |
| `<leader>gs`| **S**tage Hunk             |
| `<leader>gr`| **R**eset Hunk             |
| `<leader>gS`| **S**tage entire **B**uffer|
| `<leader>gu`| **U**ndo Stage Hunk        |
| `<leader>gR`| **R**eset Buffer           |
| `<leader>gp`| **P**review Hunk           |
| `<leader>gb`| **B**lame Line             |
| `<leader>gtb`| **T**oggle **B**lame       |

### Diagnostics (`<leader>x`)

Powered by `trouble.nvim`.

| Keymap       | Action                               |
| ------------ | ------------------------------------ |
| `]d` / `[d]` | Next/Previous Diagnostic             |
| `<leader>e`  | Show diagnostic in floating window   |
| `<leader>xx` | Toggle **D**iagnostics List (Workspace) |
| `<leader>xX` | Toggle **D**iagnostics List (Buffer) |
| `<leader>xL` | Toggle **L**ocation List             |
| `<leader>xQ` | Toggle **Q**uickfix List             |

### Formatting (`<leader>f`)

Powered by `conform.nvim` and LSP.

| Keymap      | Mode(s) | Action                               |
| ----------- | ------- | ------------------------------------ |
| `<leader>f` | Normal, Visual | **F**ormat file or selection (LSP) |
| `<leader>F` | Normal  | **F**ormat with external tool (Conform)|
| `<leader>i` | Normal  | Fix **I**ndentation (Treesitter)     |

### Other Plugin Keymaps

| Keymap        | Action                               | Plugin                |
| ------------- | ------------------------------------ | --------------------- |
| `<leader>e`   | Toggle file **E**xplorer             | `nvim-tree.lua`       |
| `<leader>o`   | F**o**cus file explorer              | `nvim-tree.lua`       |
| `<leader>u`   | Toggle **U**ndotree                  | `undotree`            |
| `<leader>a`   | Show **A**lpha dashboard             | `alpha-nvim`          |
| `<leader>sts` | **S**witch **T**heme                 | `theme-switcher.lua`  |
| `gcc`         | Toggle line comment                  | `Comment.nvim`        |
| `gbc`         | Toggle block comment                 | `Comment.nvim`        |
| `<leader>1-9` | Go to buffer 1-9                     | `bufferline.nvim`     |

---

## 4. Installed Plugins

Plugins are managed by `lazy.nvim`. The main plugin directory is `lua/synvim/plugins`.

### UI & Appearance

-   **alpha-nvim**: A fancy dashboard screen on startup.
-   **bufferline.nvim**: Minimalist buffer tabs at the top of the screen.
-   **lualine.nvim**: A sleek and informative status line at the bottom.
-   **nvim-colorizer.lua**: Highlights color codes (e.g., `#FFFFFF`) with their actual color.
-   **dressing.nvim**: Improves the UI for `vim.ui.input()` and `vim.ui.select()` with floating windows.
-   **indent-blankline.nvim**: Adds indentation guides.
-   **mini.animate**: Provides smooth animations for cursor movement, scrolling, and window resizing.
-   **noice.nvim**: A modern, floating UI for the command line, messages, and popups.
-   **render-markdown.nvim**: Renders markdown elements like headers, tables, and code blocks with rich styling inside Neovim.
-   **which-key.nvim**: Shows available keybindings in a popup when you press a leader key.

### Editing & Text Manipulation

-   **nvim-autopairs**: Automatically closes brackets, parentheses, and quotes.
-   **Comment.nvim**: Smart commenting (`gcc` to toggle line comment).
-   **conform.nvim**: A powerful and opinionated formatter that can run tools like `prettier`, `black`, and `stylua`.
-   **nvim-surround**: Easily add, change, and delete surrounding pairs like quotes or brackets (`ysiw"` to surround a word in quotes).
--   **yanky.nvim**: An improved yank/paste system with a persistent history accessible via Telescope (`<leader>sy`).

### Completion & LSP

-   **nvim-lspconfig**: The core plugin for configuring Language Server Protocol (LSP) servers.
-   **cmp.nvim**: The autocompletion engine.
-   **LuaSnip** & **friendly-snippets**: The snippet engine and a collection of useful snippets.
-   **cmp-** sources: Various plugins that provide completion sources for `cmp.nvim` (LSP, buffer, path, etc.).
-   **python-lspconfig**: Specific configuration for the `pyright` Python language server.

### Navigation & Fuzzy Finding

-   **telescope.nvim**: The primary fuzzy finder for files, buffers, help tags, and more.
-   **flash.nvim**: An incredibly fast way to jump anywhere in the visible buffer with just a few keystrokes.
-   **harpoon**: Lets you "harpoon" files for quick navigation between your most important files.
-   **nvim-tree.lua**: A fast and beautiful file explorer, configured to open on the right side.
-   **undotree**: Visualizes your undo history as a tree, so you never lose a change.

### Git Integration

-   **gitsigns.nvim**: Shows git status (added, modified, deleted lines) in the sign column and provides commands for staging hunks, viewing blame, and more.

### Utility

-   **todo-comments.nvim**: Highlights and lets you search for keywords like `TODO`, `FIXME`, and `NOTE` in your code.
-   **trouble.nvim**: A pretty list for diagnostics, references, and search results.
-   **nvim-treesitter**: Provides fast and accurate syntax highlighting, indentation, and code analysis using incremental parsing.

---

## 5. Themes

Your configuration includes a curated list of popular, aesthetically pleasing themes.

### Available Themes

-   `bamboo`
-   `catppuccin` (Default)
-   `dracula`
-   `everforest`
-   `gruvbox`
-   `kanagawa`
-   `monokai-pro`
-   `nightfox`
-   `nord`
-   `rose-pine`
-   `tokyonight`

All themes are configured to have a **transparent background**.

### Switching Themes

-   **Keymap**: Press `<leader>sts` (**S**witch **T**heme **S**elector).
-   **Action**: This will open a Telescope window allowing you to fuzzy find and live-preview all available themes. Pressing `Enter` on a selection will apply the theme and save it as the new default for future sessions.
