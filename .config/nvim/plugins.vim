" modify fzf.vim Rg command to avoid searching file names
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ 'rg --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>)
  \, 1, fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}), <bang>0)
