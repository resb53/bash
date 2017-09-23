colo pablo
syntax on
filetype plugin indent on
set expandtab
set autoindent
set smartindent
set shiftwidth=2
set tabstop=2
set spellfile=~/.spellfile.add
autocmd FileType go setlocal noexpandtab
let g:go_fmt_command = "goimports"
autocmd FileType make setlocal noexpandtab
