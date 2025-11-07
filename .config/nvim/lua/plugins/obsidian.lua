-- ~/.config/nvim/lua/plugins/obsidian.lua
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    -- Location of Obsidian vault (change this to your vault path)
    workspaces = {
      {
        name = "personal",
        path = vim.fn.expand("~/storage/shared/Documents/Syn"),
      },
    },
    -- Daily notes configuration
    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
      alias_format = "%B %-d, %Y",
      template = "daily-template",
    },
    -- Note ID and front matter
    note_id_func = function(title)
      if title ~= nil then
        return title:gsub(" ", "-"):lower()
      else
        return tostring(os.time())
      end
    end,
    note_frontmatter_func = function(note)
      local out = { id = note.id, aliases = note.aliases, tags = note.tags }
      if note.title then
        out.title = note.title
      end
      return out
    end,
    -- Obsidian link handling
    follow_url_func = function(url)
      vim.fn.jobstart({ "open", url })
    end,
    follow_img_func = function(img)
      vim.fn.jobstart({ "open", img })
    end,
    use_advanced_uri = false,
    open_notes_in = "current",
    plugins = {
      omni_ac = {},
      tags = {},
      smart_action = {},
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)
    
    local keymap = vim.keymap
    keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Obsidian New Note" })
    keymap.set("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" })
    keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Daily Note" })
    keymap.set("n", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Obsidian Link" })
  end,
}

