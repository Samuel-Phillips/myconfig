func! DoRemote(arg)
    UpdateRemotePlugins
endfunc

" arduino.vim
Plug 'lambdatoast/elm.vim'
Plug 'othree/html5.vim'
" Plug 'mattn/invader-vim'
" java_apidoc.vim
Plug 'fs111/pydoc.vim'
Plug 'hdima/python-syntax'
Plug 'rust-lang/rust.vim'
Plug 'vim-scripts/svg.vim'
" Plug 'scrooloose/syntastic'
Plug 'vim-scripts/taglist.vim'
Plug 'Shougo/unite.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jplaut/vim-arduino-ino'
Plug 'vim-scripts/vim-auto-save'
Plug 'kchmck/vim-coffee-script' " TODO: kill trailing WS shit
" Plug 'altercation/vim-colors-solarized' " in favor of:
Plug 'Samuel-Phillips/nvim-colors-solarized'
Plug 'dag/vim-fish'
Plug 'tpope/vim-fugitive'
Plug 'tikhomirov/vim-glsl'
Plug 'gkz/vim-ls' " TODO: kill damn identifier highlighting
Plug 'vim-scripts/sql.vim--Stinson'

Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'alunny/pegjs-vim'

Plug 'airblade/vim-gitgutter'

Plug 'vim-scripts/Conque-GDB'


Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'zchee/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs'
"Plug 'zchee/deoplete-clang'
Plug 'Rip-Rip/clang_complete'

Plug 'carlitux/deoplete-ternjs'
"Plug 'm2mdas/phpcomplete-extended'
Plug 'racer-rust/vim-racer'
