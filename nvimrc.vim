if !has('nvim')
    set nocompatible
endif

call plug#begin('~/.config/nvim/plugged')
runtime myconfig/plugins.vim
call plug#end()

runtime myconfig/util.vim
runtime myconfig/setup.vim
runtime myconfig/mappings.vim
runtime myconfig/abbrev.vim
runtime myconfig/vimrc.vim
runtime myconfig/vam.vim

autocmd FileType arduino setl shell=/bin/sh

autocmd FileType help,vim setl keywordprg=:help
