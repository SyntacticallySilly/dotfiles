# Synvim: Neovim That Feels Fast (Even On Termux)

Synvim is a Lua-based Neovim setup built for speed and simplicity on Android. It uses lazy loading, clean UI, and practical keybinds.

This guide keeps things plain and human-friendly and reflects the actual config files in this repo.

---

## Where The Config Lives

Everything is in `~/.config/nvim`:

- `init.lua` → entry point
- `lua/synvim/core/` → options, keymaps, autocmds, lazy.nvim bootstrap
- `lua/synvim/plugins/` → plugin configs
- `lua/synvim/colorschemes/` → theme configs
- `lazy-lock.json` → pinned plugin versions

---

## Plugin Manager: lazy.nvim

Synvim uses **lazy.nvim**. It auto-installs itself if missing and loads plugins only when needed.

Open the plugin UI:

```
:Lazy
```

---

## Core Settings (What It Feels Like)

From `core/options.lua`:

- Line numbers + relative numbers
- 2-space indent, spaces not tabs
- No swap/backup files
- Persistent undo
- Rounded floating windows
- Transparent UI elements
- `termguicolors` enabled
- Fold method uses Treesitter

---

## Autocmd Behavior

From `core/autocmds.lua`:

- Restores cursor position when reopening files
- Markdown files: wrap + spell + linebreak
- Auto-creates parent folders on save
- Always starts Treesitter on filetype
- CursorHold shows diagnostics in a float

---

## LSP + Completion

Configured servers (see `plugins/lspconfig.lua`):

- `clangd`, `lua_ls`, `taplo`, `gopls`, `pyright`, `rust_analyzer`

Completion is handled by **blink.cmp** with `preset = "enter"`.

If a language server is missing, install it with `pkg` or `npm` depending on the server.

---

## Treesitter

Treesitter powers syntax highlighting and folding.

- Parsers install to `~/bin/TS/parsers`
- Includes many languages (bash, lua, rust, go, js/ts, markdown, etc.)

---

## Keymap Cheatsheet (Actual Config)

Leader is **space**.

### Core Navigation + Editing

- `<leader>wv` split vertical
- `<leader>wH` split horizontal
- `<leader>wq` close window
- `<leader>wo` close other windows
- `<leader>w=` equal window sizes
- `<leader>wh` / `wj` / `wk` / `wl` move between windows
- `<leader>bn` / `<leader>bp` next/prev buffer
- `<leader>bd` delete buffer
- `<Space><Space>` system clipboard register (n/v/x)
- `n` / `N` next/prev search result (keeps cursor centered)
- `<C-d>` / `<C-u>` scroll down/up (keeps cursor centered)
- `<C-Up>` / `<C-Down>` / `<C-Left>` / `<C-Right>` resize splits
- `jk` in insert mode → escape
- `jk` in command-line mode → escape
- `J` join lines without moving cursor
- `U` redo
- `[q` / `]q` quickfix prev/next
- `<Esc>` clears search highlight

### Mini.nvim (Text Objects, Surround, Comment, Motions)

- `gc` comment selection, `gcc` comment line
- `gsa` add surround, `gsd` delete, `gsr` replace, `gsf`/`gsF` find, `gsh` highlight, `gsn` update n_lines
- Text objects (mini.ai): `a`/`i` plus `gan`/`gin` (next), `gal`/`gil` (last), `g[`/`g]` (jump)
- Bracketed motions (mini.bracketed): `[` or `]` + suffix
- Suffixes enabled: `b` buffer, `c` comment, `d` diagnostic, `f` file, `i` indent, `j` jump, `l` location, `o` oldfile, `q` quickfix, `t` treesitter, `u` undo, `w` window, `y` yank

### File + Explorer

- `<leader>E` open **mini.files** in current working directory
- `<leader>e` opens **Oil** floating file explorer (this overrides the mini.files mapping)
- `<leader>ffl` format (normal) / format selection (visual)
- `<leader>ffi` fix indentation
- `<leader>fs` rip-substitute (find/replace)
- `<leader>fa` toggle Aerial symbols
- `<leader>fA` toggle Aerial nav window

### LSP

- `K` hover docs
- `<C-k>` signature help
- `<leader>cr` rename symbol
- `<leader>ca` code action
- `[d` / `]d` prev/next diagnostic

### Search (Snacks Picker)

- `<leader>sf` files
- `<leader>sv` git files
- `<leader>sg` live grep
- `<leader>sb` buffers
- `<leader>sh` help
- `<leader>sr` recent files
- `<leader>sc` commands
- `<leader>sk` keymaps
- `<leader>sd` diagnostics
- `<leader>st` colorschemes
- `<leader>sn` notifications
- `<leader>sm` resume last picker
- `<leader>s%` current buffer lines
- `<leader>sa` LSP symbols
- `<leader>s"` registers
- `<leader>si` icons
- `<leader>s:` command history
- `<leader>s/` search history
- `<leader>sw` grep word under cursor (normal or visual)
- `<leader>su` undo history

Also LSP navigations via Snacks:

- `gd` goto definition
- `gD` goto declaration
- `gr` references
- `gI` implementations
- `gy` type definition
- `gai` incoming calls
- `gao` outgoing calls

Snacks picker window keys:

- `<C-j>` / `<C-k>` move list
- `<C-n>` / `<C-p>` history forward/back
- `<C-q>` send to quickfix
- `<C-u>` / `<C-d>` scroll preview
- `jk` cancel (insert mode)

Snacks buffer picker extras:

- `x` / `dd` delete buffer from list
- `<C-x>` delete buffer (input)

Snacks dashboard keys (on start screen):

- `f` find file
- `n` new file
- `e` explore (Oil)
- `g` find text
- `r` recent files
- `c` config files
- `s` restore session
- `l` Lazy UI
- `q` quit

### Diagnostics (Trouble)

- `<leader>xx` workspace diagnostics
- `<leader>xX` buffer diagnostics
- `<leader>cs` symbols (Trouble)
- `<leader>cl` LSP list (right)
- `<leader>xL` location list
- `<leader>xQ` quickfix list

Inside Trouble window:

- `q` close
- `<Esc>` cancel
- `r` refresh
- `j` / `k` move
- `<CR>` jump
- `<Tab>` jump
- `<C-x>` open split
- `<C-v>` open vsplit
- `<C-t>` open tab
- `m` toggle mode
- `o` jump + close
- `P` toggle preview
- `p` preview
- `K` hover
- `zM` / `zm` close folds
- `zR` / `zr` open folds
- `zA` / `za` toggle fold

### Git (Neogit)

- `<leader>gg` status
- `<leader>gc` commit
- `<leader>gp` push
- `<leader>gl` pull
- `<leader>gB` branch
- `<leader>gd` diff
- `<leader>gS` stash
- `<leader>gr` rebase
- `<leader>gm` merge
- `<leader>gf` fetch
- `<leader>gL` log
- `<leader>gR` reset
- `<leader>gC` cherry-pick
- `<leader>gw` worktree

### GitHub (Octo)

- `<leader>oi` list issues
- `<leader>op` list PRs
- `<leader>od` list discussions
- `<leader>on` list notifications
- `<leader>os` search

### Bookmarks (Arrow)

- `H` previous bookmark
- `L` next bookmark
- `<leader>bb` toggle bookmark
- `<leader>bx` clear all bookmarks
- `<leader>1`..`<leader>9` jump to bookmark index

Arrow menu leader key is `&` (opens Arrow menu). Default `&` was removed to free the key.

Inside Arrow menu:

- `e` edit
- `s` toggle bookmark
- `x` remove
- `C` clear all
- `v` vertical split
- `-` horizontal split
- `[` / `]` prev/next item
- `q` close

### TODO Comments

- `[t` / `]t` previous/next TODO
- `<leader>st` list TODOs (picker)
- `<leader>xq` TODO quickfix list

### Notifications

- `<leader>nd` dismiss notifications (Noice + notify)

### Color Tools

- `<leader>fc` toggle Colorizer
- `<leader>fp` open Colortils (color picker)
- `<leader>cc` open Colortils (alias)

Colortils window keys:

- `h` / `l` adjust
- `H` / `L` big adjust
- `<CR>` replace
- `g<CR>` replace in other format
- `q` exit

### Symbols (Aerial)

- `[a` / `]a` prev/next symbol
- `{` / `}` also mapped to prev/next symbol (buffer-local)

Aerial window keys include:

- `<CR>` jump
- `<2-LeftMouse>` jump
- `<C-v>` jump in vsplit
- `<C-s>` jump in split
- `q` close
- `o` / `za` toggle tree
- `O` / `zA` toggle tree recursive
- `h` / `l` close/open
- `H` / `L` close/open recursive
- `zR` / `zM` open/close all
- `zr` / `zm` increase/decrease fold level
- `zx` / `zX` sync folds

Aerial nav window keys:

- `<CR>` / `<2-LeftMouse>` jump
- `<C-v>` / `<C-s>` split/vsplit
- `h` / `l` move left/right
- `<C-c>` / `q` close

### Undo Tree (Atone)

- `<leader>fu` open Atone

Inside Atone:

- `j` / `k` move
- `<CR>` undo to state
- `q` / `<Esc>` close
- `?` help

### Quickfix (Quicker)

Active only in quickfix buffers:

- `>` expand quickfix entry

### File Manager (Oil)

Open Oil (floating):

- `<leader>e`

Inside Oil buffer:

- `g?` help
- `l` open/select
- `<C-l>` refresh
- `h` go to parent
- `<C-s>` open vertical split
- `<C-h>` open horizontal split
- `<C-t>` open in tab
- `<C-p>` preview
- `_` open cwd
- `` ` `` change directory
- `g~` change directory for tab
- `gx` open external
- `g.` toggle hidden
- `g\\` toggle trash
- `gs` change sort
- `q` close

Note: `use_default_keymaps = true`, so Oil defaults also apply.

### Markdown (markdown.nvim)

Active only in Markdown files:

- `gs` toggle surround
- `gss` toggle surround line
- `ds` delete surround
- `cs` change surround
- `gl` add link
- `gx` open link
- `]c` / `]p` / `]]` / `[[` heading navigation
- `<M-l><M-o>` / `<M-L><M-O>` add list item below/above
- `<M-c>` toggle checkbox
- Visual mode: `<C-b>` / `<C-i>` bold/italic

### Completion (blink.cmp)

- `<C-space>` show completion + docs
- `<C-e>` hide
- `<C-n>` / `<C-p>` next/prev
- `<C-j>` / `<C-k>` next/prev
- `<Up>` / `<Down>` next/prev
- `<Tab>` / `<S-Tab>` snippet forward/back
- `<C-b>` / `<C-f>` scroll docs

### AI Suggestions (Supermaven)

- `<C-y>` accept suggestion
- `<C-]>` clear suggestion
- `<C-j>` accept word

---

## Notes About Disabled Plugins

These are present in config but disabled, so their keymaps won’t work unless you enable them:

- **flash.nvim**: `s`, `S`, `r`, `R`, `<C-s>` (cmdline) → disabled
- **grug-far.nvim**: `<leader>sar`, `<leader>saR` (normal), `<leader>sar` (visual) → disabled
  Inside grug-far if enabled:
  - `<localleader>r` replace
  - `<localleader>q` quickfix
  - `<localleader>s` sync locations
  - `<localleader>l` sync line
  - `<localleader>h` history
  - `<localleader>a` add history
  - `<localleader>f` refresh
  - `<localleader>o` open location
  - `<localleader>x` abort
  - `g?` help
  - `q` close
  - `<CR>` jump

---

## UI / Editing Plugins (Plain English)

Some notable plugins you’ll notice:

- **mini.nvim**: text objects, surround, comment, pairs, bracketed motions
- **noice + notify**: nicer command-line messages and popups
- **which-key**: keybind hints
- **gitsigns + neogit**: Git in the editor
- **trouble + todo-comments**: diagnostics + TODO list
- **aerial**: file symbol outline
- **render-markdown**: better Markdown rendering
- **oil**: file manager in a buffer

---

## Themes + Transparency

- Multiple themes are preconfigured (`rose-pine`, `catppuccin`, `kanagawa`, `everforest`)
- Transparency is enabled via `core/transparent.lua`

If you want solid backgrounds, disable that module in `init.lua`.

---

## Quick Troubleshooting

- **LSP not working?** Make sure the language server binary exists in `$PATH`.
- **Slow startup?** Run `:Lazy` and check for plugin errors.
- **Weird colors?** Try `:colorscheme rose-pine`.

---

## Related Doc

Shell + Termux setup is documented in `syndot.md`.
