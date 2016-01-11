" Enable spellchecking
setlocal spell

" Automatically wrap at 80 characters
setlocal textwidth=80

if !empty(glob("~/.config/nvim/plugged/goyo.vim"))
    call pencil#init()
endif
