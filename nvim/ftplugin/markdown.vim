" Pencil can change reset some settings, so initialize it first
if !empty(glob("~/.config/nvim/plugged/vim-pencil"))
	call pencil#init()
endif

" Enable spellchecking
setlocal spell

" Tell autoformatting the width to use
setlocal textwidth=80

" Make it obvious where 80 characters is
setlocal colorcolumn=81
