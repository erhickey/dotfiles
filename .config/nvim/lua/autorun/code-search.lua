require('nvim-github-codesearch').setup({
  -- alternatively, you can configure this parameter by export an environment variable named "GITHUB_AUTH_TOKEN"
  -- github_auth_token = "<YOUR GITHUB API KEY>",
  github_api_url = "https://api.github.com",
  use_telescope = false,
})

local wk = require('which-key')
wk.register({
  h = {
    name = 'GitHub Code Search',
    h = { "<Cmd>lua require'nvim-github-codesearch'.prompt()<CR>", 'Code Search Prompt' },
    x = { "<Cmd>lua require'nvim-github-codesearch'.cleanup()<CR>", 'Delete Code Search Temp Files'},
  },
}, { prefix = '<leader>' })
