let g:LanguageClient_settingsPath = "~/.config/nvim/lcn.json"
let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})

" haskell
" https://github.com/haskell/haskell-language-server
let g:LanguageClient_serverCommands.haskell = ['haskell-language-server-wrapper', '--lsp', '--logfile', '/tmp/hls.log']

" python
" pip install python-language-server
let g:LanguageClient_serverCommands.python = ['pyls', '-vv', '--log-file', '/tmp/pyls.log']

" typescript
" npm install -g typescript-language-server
let g:LanguageClient_serverCommands.typescript = ['typescript-language-server', '--stdio']
