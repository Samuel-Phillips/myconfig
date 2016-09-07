if !has('nvim')
    set nocompatible
endif

runtime myconfig/presetup.vim

call plug#begin('~/.config/nvim/plugged')
runtime myconfig/plugins.vim
Plug '~/.config/nvim/myconfig/always'
call plug#end()

runtime myconfig/util.vim
runtime myconfig/setup.vim
runtime myconfig/abbrev.vim
runtime myconfig/vam.vim
