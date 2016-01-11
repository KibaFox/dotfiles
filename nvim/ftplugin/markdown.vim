" Enable spellchecking
setlocal spell

if !empty(glob("~/.config/nvim/plugged/goyo.vim"))
    call pencil#init()
endif
