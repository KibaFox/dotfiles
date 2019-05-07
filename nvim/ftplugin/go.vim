" Run Neomake on every write
call neomake#configure#automake('rw')
let g:neomake_go_enabled_makers = ['go', 'gometalinter']
let g:neomake_go_gometalinter_maker = {
	\ 'exe': 'gometalinter.v2',
	\ 'args': [
		\ '--tests',
		\ '--disable-all',
		\ '--enable=errcheck',
		\ '--enable=golint',
		\ '--enable=ineffassign',
		\ '--enable=misspell',
		\ '--enable=vet',
		\ '--exclude=^\S+\.pb\.go',
		\ '--exclude=should not use dot imports',
		\ '--exclude=defer [\pL\pN.]+\.Close\(\)'
	\ ],
	\ 'append_file': 0,
	\ 'cwd': '%:h',
	\ 'errorformat': '%f:%l:%c:%t%*[^:]: %m',
\ }
