call plug#begin('~/.config/nvim/plugged')
source plugins.vim
call plug#end()

source vimrc.vim

" set up vam {{{
fun! SetupVAM()
  let c = get(g:, 'vim_addon_manager', {})
  let g:vim_addon_manager = c
  let c.plugin_root_dir = expand('$HOME', 1) . '/.vim/vim-addons'

  " Force your ~/.vim/after directory to be last in &rtp always:
  " let g:vim_addon_manager.rtp_list_hook = 'vam#ForceUsersAfterDirectoriesToBeLast'

  " most used options you may want to use:
  " let c.log_to_buf = 1
  " let c.auto_install = 0
  let &rtp.=(empty(&rtp)?'':',').c.plugin_root_dir.'/vim-addon-manager'
  if !isdirectory(c.plugin_root_dir.'/vim-addon-manager/autoload')
    execute '!git clone --depth=1 git://github.com/MarcWeber/vim-addon-manager '
        \       shellescape(c.plugin_root_dir.'/vim-addon-manager', 1)
  endif

  " This provides the VAMActivate command, you could be passing plugin names, too
  call vam#ActivateAddons([], {})
endfun
call SetupVAM()

VAMActivateInstalled
" }}}
" Solarized {{{
set background=dark

let g:solarized_termtrans=1
" let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
" let g:solarized_termcolors=16
" let g:solarized_contrast="normal"
" let g:solarized_visibility="normal"
" let g:solarized_diffmode="normal"
" let g:solarized_hitrail=0
" }}}
set shell=fish
autocmd FileType arduino setl shell=/bin/sh

autocmd FileType help,vim setl keywordprg=:help

let g:airline_theme='solarized'
let g:airline_powerline_fonts = 1
set noshowmode

" Crap to get pydoc to work {{{
let g:pydoc_cmd = "pydoc3"
let g:pydoc_open_cmd = "tabnew"
" }}}

let g:python_host_prog = "/usr/bin/python"
let g:python3_host_prog = "/usr/bin/python3"

tnoremap <C-Z> <C-\><C-n>
tnoremap <C-R> <C-\><C-n>kyypi

nnoremap Y y$

let g:solarized_menu=1
