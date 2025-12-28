# Synvim: The Opinionated Neovim Guide

Synvim is a highly customized and performance-focused Neovim configuration, designed to be a fast, modern, and efficient text editor within the Termux environment. It is built on Lua and managed by the `lazy.nvim` plugin manager.

## Table of Contents

1.  [Core Philosophy](#1-core-philosophy)
2.  [Structure of the Configuration](#2-structure-of-the-configuration)
3.  [Plugin Management (`lazy.nvim`)](#3-plugin-management-lazynvim)
4.  [Keybindings](#4-keybindings)
    -   [Leader Key](#leader-key)
    -   [Telescope (Search)](#telescope-search)
    -   [Harpoon (Navigation)](#harpoon-navigation)
    -   [Window and Buffer Management](#window-and-buffer-management)
    -   [Formatting](#formatting)
5.  [Core Plugins Deep Dive](#5-core-plugins-deep-dive)
    -   [UI & Appearance](#ui--appearance)
    -   [Editing & Text Manipulation](#editing--text-manipulation)
    -   [Navigation & Motion](#navigation--motion)
    -   [LSP & Development](#lsp--development)
    -   [Git Integration](#git-integration)
6.  [Theming](#6-theming)
    -   [Theme Switcher](#theme-switcher)
    -   [Transparency](#transparency)
7.  [Full Plugin List](#7-full-plugin-list)

---

## 1. Core Philosophy

-   **Performance First**: Every plugin and setting is chosen with the constraints of a mobile environment in mind. Lazy loading is used extensively to ensure fast startup times.
-   **Modal and Mnemonic**: Keybindings are organized logically under the `<leader>` key, following a mnemonic structure (e.g., `<leader>s` for search, `<leader>h` for harpoon).
-   **Visually Clean**: The UI is designed to be minimal yet informative, with a focus on transparency and modern aesthetics.
-   **Integrated Experience**: Tools like Telescope, Harpoon, and the LSP are deeply integrated to provide a seamless workflow for searching, navigating, and writing code.

---

## 2. Structure of the Configuration

The Neovim configuration lives in `~/.config/nvim`. The structure is as follows:

-   `init.lua`: The main entry point. It loads settings, the plugin manager, and the theme.
-   `lua/synvim/`: The core configuration directory.
    -   `lazy.lua`: Bootstraps the `lazy.nvim` plugin manager.
    -   `settings.lua`: Contains all core Neovim options (`vim.opt`).
    -   `keymaps.lua`: Defines all the keybindings.
    -   `theme-switcher.lua`: A custom module for interactively switching themes.
    -   `transparent.lua`: A module to apply transparent backgrounds to UI elements.
    -   `plugins/`: A directory where each file represents a plugin or a group of related plugins.
    -   `themes/`: A directory where each file defines a colorscheme plugin.

---

## 3. Plugin Management (`lazy.nvim`)

Synvim uses `lazy.nvim` for plugin management. It is configured to lazy-load almost every plugin, meaning they are only loaded when they are actually needed (e.g., on a specific command, filetype, or event). This is crucial for maintaining a fast startup time.

-   **Configuration**: The plugin specifications are located in the `lua/synvim/plugins/` and `lua/synvim/themes/` directories.
-   **Interface**: You can open the `lazy.nvim` interface by running the command `:Lazy`.

---

## 4. Keybindings

### Leader Key

The leader key is set to the **spacebar**. All custom keybindings are prefixed with `<leader>`.

### Telescope (Search)

Telescope is the central fuzzy finder. All search-related actions are grouped under `<leader>s`.

| Keybinding | Action |
|---|---|
| `<leader>sf` | Search for files. |
| `<leader>sg` | Search for a string in all files (live grep). |
| `<leader>sb` | Search through open buffers. |
| `<leader>sh` | Search help tags. |
| `<leader>sr` | Search recent files. |
| `<leader>sk` | Search keymaps. |
| `<leader>sc` | Search commands. |
| `<leader>st` | Search for TODO comments. |
| `<leader>sts`| Switch themes. |

### Harpoon (Navigation)

Harpoon is used for quick navigation between frequently used files. All harpoon actions are under `<leader>h`.

| Keybinding | Action |
|---|---|
| `<leader>ha` | Add the current file to the harpoon list. |
| `<leader>hm` | Show the harpoon menu. |
| `<leader>h1` - `<leader>h4` | Jump to the corresponding file in the harpoon list. |
| `<C-S-P>` / `<C-S-N>` | Navigate to the previous/next harpoon mark. |

### Window and Buffer Management

| Keybinding | Action |
|---|---|
| `<leader>wv` / `<leader>wh` | Split window vertically/horizontally. |
| `<leader>wc` / `<leader>wo` | Close current/other windows. |
| `<C-h/j/k/l>` | Move between windows. |
| `<leader>bn` / `<leader>bp` | Go to the next/previous buffer. |
| `<leader>bd` | Close the current buffer. |
| `<leader>e` | Open a file explorer in the current file's directory. |
| `<leader>E` | Open a file explorer in the current working directory. |

### Formatting

| Keybinding | Action |
|---|---|
| `<leader>f` | Format the current file or visual selection using LSP. |
| `<leader>i` | Fix indentation for the entire file. |

---

## 5. Core Plugins Deep Dive

### UI & Appearance

-   **`lualine.nvim`**: A minimal and modern status line that shows the current mode, git branch, file path, battery status, and time.
-   **`bufferline.nvim`**: Provides clean and simple buffer tabs at the top of the screen.
-   **`noice.nvim`**: Replaces the default command line with a floating input, and enhances the UI for messages and notifications.
-   **`alpha-nvim`**: A beautiful and functional dashboard that greets you on startup, providing quick access to common actions.
-   **`dressing.nvim`**: Improves the default UI for `vim.ui.input()` and `vim.ui.select()` with floating windows.
-   **`nvim-web-devicons`**: Adds file type icons to many plugins like Telescope and Lualine.

### Editing & Text Manipulation

-   **`blink.cmp`**: A performant and feature-rich completion engine. It uses the enter key for completion and provides snippet support.
-   **`Comment.nvim`**: Smart commenting that automatically uses the correct comment syntax for the file type.
-   **`nvim-surround`**: Easily add, change, and delete surrounding pairs like quotes, brackets, and parentheses.
-   **`yanky.nvim`**: An improved yank and put system with a persistent yank history, accessible via Telescope.
-   **`conform.nvim`**: A modern formatter that can handle indentation and formatting on save.

### Navigation & Motion

-   **`flash.nvim`**: A revolutionary navigation plugin that allows you to jump anywhere on the screen with just two keystrokes.
-   **`neoscroll.nvim`**: Provides smooth scrolling animations for a more pleasant viewing experience.
-   **`vim-illuminate`**: Highlights all occurrences of the word under the cursor, making it easy to see where a variable is used.

### LSP & Development

-   **`nvim-lspconfig`**: The core plugin for configuring Language Server Protocol (LSP) clients.
-   **`pyright`**, **`rust-analyzer`**, **`lua_ls`**: Pre-configured language servers for Python, Rust, and Lua.
-   **`trouble.nvim`**: A beautiful and powerful UI for viewing diagnostics, references, and other lists.
-   **`todo-comments.nvim`**: Highlights and allows you to search for TODO, FIXME, and other keywords in your code.

### Git Integration

-   **`gitsigns.nvim`**: Adds git decorations to the sign column, allowing you to see which lines have been added, modified, or deleted. It also provides commands for staging, resetting, and previewing hunks.

---

## 6. Theming

### Theme Switcher

Synvim includes a custom theme switcher that allows you to change your colorscheme on the fly.

-   **Keybinding**: `<leader>sts`
-   **Functionality**: It opens a Telescope window with a list of all available themes. As you navigate the list, it provides a live preview of each theme. When you select a theme, it is applied and saved as your new default.

### Transparency

The configuration is designed to be transparent by default. The `transparent.lua` module ensures that all major UI elements, including floating windows, menus, and sidebars, have a transparent background, allowing your terminal's background to show through.

---

## 7. Full Plugin List

Below is a list of all the plugins included in Synvim, categorized by their function.

<details>
<summary><strong>UI & Appearance</strong></summary>

-   `alpha-nvim` (Dashboard)
-   `bamboo.nvim` (Theme)
-   `bufferline.nvim` (Buffer tabs)
-   `catppuccin` (Theme)
-   `darkvoid.nvim` (Theme)
-   `dracula.nvim` (Theme)
-   `dressing.nvim` (UI for input/select)
-   `everforest-nvim` (Theme)
-   `gruvbox.nvim` (Theme)
-   `kanagawa.nvim` (Theme)
-   `lualine.nvim` (Status line)
-   `monokai-pro.nvim` (Theme)
-   `nightfox.nvim` (Theme)
-   `noice.nvim` (Command line UI)
-   `nord.nvim` (Theme)
-   `nvim-web-devicons` (Icons)
-   `rainbow-delimiters.nvim` (Colored brackets)
-   `render-markdown.nvim` (Markdown rendering)
-   `rose-pine` (Theme)
-   `tokyonight.nvim` (Theme)
-   `which-key.nvim` (Keybinding hints)

</details>

<details>
<summary><strong>Editing & Completion</strong></summary>

-   `blink.cmp` (Completion engine)
-   `Comment.nvim` (Smart commenting)
-   `conform.nvim` (Formatting)
-   `friendly-snippets` (Snippets collection)
-   `nvim-surround` (Surrounding pairs)
-   `yanky.nvim` (Yank history)

</details>

<details>
<summary><strong>Navigation & Motion</strong></summary>

-   `beacon.nvim` (Cursor jump highlighting)
-   `flash.nvim` (Fast navigation)
-   `harpoon` (Quick file navigation)
-   `neoscroll.nvim` (Smooth scrolling)
-   `nvim-luxmotion` (Smooth motion animations)
-   `telescope-file-browser.nvim` (File browser)

</details>

<details>
<summary><strong>LSP & Development</strong></summary>

-   `ccc.nvim` (Color picker)
-   `colorful-menu.nvim` (LSP menu theming)
-   `lspkind.nvim` (Icons for LSP)
-   `nvim-lspconfig` (LSP configuration)
-   `nvim-treesitter` (Syntax parsing)
-   `todo-comments.nvim` (TODO highlighting)
-   `trouble.nvim` (Diagnostics UI)

</details>

<details>
<summary><strong>Utilities & Others</strong></summary>

-   `gitsigns.nvim` (Git integration)
-   `lazy.nvim` (Plugin manager)
-   `markdown.nvim` (Markdown tools)
-   `nerdy.nvim` (Nerd font icon picker)
-   `nui.nvim` (UI component library)
-   `obsidian.nvim` (Obsidian integration)
-   `plenary.nvim` (Utility library)
-   `termux.nvim` (Termux integration)
-   `undo-glow.nvim` (Undo/redo animations)
-   `undotree` (Visual undo history)
-   `vim-be-good` (Vim practice game)
-   `wilder.nvim` (Command line completion)

</details>