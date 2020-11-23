set runtimepath^=~/.vim
let &packpath = &runtimepath
source ~/.vimrc

let g:LanguageClient_settingsPath = "~/.config/nvim/lcn-settings.json"
let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
let g:LanguageClient_serverCommands.haskell = ['haskell-language-server-wrapper', '--lsp', '--logfile', '/tmp/hls.log']
let g:LanguageClient_serverCommands.python = ['/bin/pyls', '-vv', '--log-file', '/tmp/pyls.log']

nnoremap <F5> :call LanguageClient_contextMenu()<CR>
map <Leader>le :call LanguageClient#explainErrorAtPoint()<CR>
map <Leader>lh :call LanguageClient#textDocument_hover()<CR>
map <Leader>ld :call LanguageClient#textDocument_definition()<CR>
map <Leader>lr :call LanguageClient#textDocument_rename()<CR>
map <Leader>lf :call LanguageClient#textDocument_formatting()<CR>
map <Leader>ll :call LanguageClient#textDocument_rangeFormatting()<CR>
map <Leader>lg :call LanguageClient#textDocument_references()<CR>
map <Leader>la :call LanguageClient#textDocument_codeAction()<CR>
map <Leader>ls :call LanguageClient#textDocument_documentSymbol()<CR>
