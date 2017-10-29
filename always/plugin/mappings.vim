" Make it easier to get to normal mode from a terminal
if has('nvim')
    tnoremap <C-Z> <C-\><C-n>
endif
"tnoremap <C-R> <C-\><C-n>kyypi

" I'll never record macros in visual mode
vnoremap q <esc>

" This should be the default
nnoremap Y y$

" Capitalization macros
inoremap <c-u> <esc>mxviwU<esc>`xa
nnoremap <leader>u mxviwU<esc>`xl

" .vimrc macros
"nnoremap <leader>rc :split $MYVIMRC<cr>G
"nnoremap <leader>src :source $MYVIMRC<cr>
"nnoremap <leader>wrc :wq<cr>:source $MYVIMRC<cr>

" Useful macros for H and L
noremap H <home>
noremap L <end>

" Replace Escape with 'jk'
inoremap jk <esc>

" Make searching easier
nnoremap <leader>s :%s/\v
nnoremap / /\v
nnoremap ? ?\v
nnoremap <leader>h :nohlsearch<cr>
nnoremap <leader>* mz*`z
   
" Make delete work properly
"inoremap <delete> <Esc>l"_xi

" Add "grep command"
"nnoremap <leader>g :grep -R '<cword>' .<cr>

" F*** DOS!

" Had to remove this because of it's awful name
"nnoremap <leader>fix-nl :%s/\v\r\n/<C-v><cr>/g<cr>:%s/\v\r/<C-v><cr>/g<cr>

" Implement C's main
"nnoremap <leader>cmain i#include <lt>stdlib.h><cr>#include <lt>stddef.h><cr>#include <lt>string.h><cr>#include <lt>stdio.h><cr><cr>int main(int argc, char* argv[]) {<cr>

" Make it easier to type commands
noremap ; :

" Add line to top of file
nnoremap <leader>u "xddmxgg:let g:my_search_cache = @/<cr>/\v^\s*$<cr>"xP:let @/ = g:my_search_cache<cr>'x

" Break long lines
nnoremap <leader>k <home>gqj

" Choose whether the mouse is active
nnoremap <leader>m :set mouse=a<cr>
nnoremap <leader>M :set mouse-=a<cr>

" Spell stuff
nnoremap <leader>z :silent! normal! z=1<cr><cr>
" Why the fuck is this mapped?
nnoremap zq zg

" Pure awesomeness " Dosen't work :(
"vnoremap <leader>g :call b:TheGoogleFunction(1)<cr>
"
" Unite bindings
nnoremap <leader>f :<C-u>Unite -no-split file<CR>
nnoremap <leader>F :<C-u>Unite -no-split -start-insert file<CR>
nnoremap <leader>sf :split<cr>:<C-u>Unite -no-split file<CR>
nnoremap <leader>sF :split<cr>:<C-u>Unite -no-split -start-insert file<CR>

autocmd BufReadPost quickfix nnoremap <Space> <CR>:lcl<CR>

" Easy fugitive
nnoremap <leader>g :G

" User-defined commands
command! Eimacs call s:FixEimacs()
command! -nargs=1 Doc !man <args>
