" Run Neomake on every write
call neomake#configure#automake('rw')
let g:neomake_go_enabled_makers = ['go', 'gometalinter']
let g:neomake_go_gometalinter_maker = {
    \ 'exe': 'gometalinter.v1',
    \ 'args': [
        \ '--tests',
        \ '--disable-all',
        \ '--enable=errcheck',
        \ '--enable=dupl',
        \ '--enable=goconst',
        \ '--enable=gocyclo',
        \ '--enable=golint',
        \ '--enable=ineffassign',
        \ '--enable=lll',
        \ '--enable=misspell',
        \ '--enable=vet',
        \ '--cyclo-over=12',
        \ '--exclude=^\S+\.pb\.go',
        \ '--exclude=should not use dot imports',
        \ '--exclude=defer [\pL\pN.]+\.Close\(\)'
    \ ],
    \ 'append_file': 0,
    \ 'cwd': '%:h',
    \ 'errorformat': '%f:%l:%c:%t%*[^:]: %m',
\ }
