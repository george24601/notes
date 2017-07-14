execute pathogen#infect()
syntax on
filetype plugin indent on

if !exists('g:vim_scala_own_settings') || !g:vim_scala_own_settings
        setlocal textwidth=140
        setlocal shiftwidth=2
        setlocal softtabstop=2
        setlocal expandtab
        setlocal formatoptions=tcqr
endif
