" Run Neomake on every write
autocmd! BufWritePost,BufEnter * Neomake

" Use 2 spaces for indentation
setlocal expandtab
setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
