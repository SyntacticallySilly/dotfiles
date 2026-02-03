return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      provider = 'openai_compatible',
      request_timeout = 2.5,
      throttle = 1500,       -- ms between requests
      debounce = 600,        -- ms delay before request
      context_window = 8000, -- chars (~2k tokens)
      context_ratio = 0.75,
      n_completions = 2,
      provider_options = {
        openai_compatible = {
          -- api_key = 'OPENROUTER_API_KEY',     -- env var name
          api_key = "sk-or-v1-6b4eb73627ac31525e592d04b4d0d580f8a521dae5321f6d66466b33e8159e5",
          end_point = 'https://openrouter.ai/api/v1/chat/completions',
          model = 'mistralai/devstral-small', -- fast/cheap coding model
          name = 'Openrouter',
          optional = {
            max_tokens = 56,
            top_p = 0.9,
            provider = { sort = 'throughput' }, -- fastest models first
          },
        },
      },
      -- add kimi2 thinking too.

      virtualtext = {
        auto_trigger_ft = { 'rust', 'cpp', 'go', 'java', 'javascript', 'lua' }, -- your langs
        keymap = {
          accept = '<A-A>',
          accept_line = '<A-a>',
          accept_n_lines = '<A-z>',
          next = '<A-]>',
          prev = '<A-[>',
          dismiss = '<A-e>',
        },
      },
    }
  end,
  { 'nvim-lua/plenary.nvim' },
}
