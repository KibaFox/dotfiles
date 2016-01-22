" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80

if !empty(glob("~/.config/nvim/plugged/vim-pencil"))
    call pencil#init()
endif
