# myconfig
My vim configuration (uses [vim-plug][1]).

This is organized in a somewhat unusual way. I don't like having all my stuff in a single vimrc/init.vim, so I use an init.vim that simply reads:
  
  runtime myconfig/nvimrc.vim

And then clone this repository into `~/.config/nvim/myconfig`.

One problem is this means that vim-plug won't update my stuff, which isn't ideal.

# How it works

`myconfig/nvimrc.vim` starts by running vim-plug. Then, it proceeds to some various files that do things.

Additionaly, it contains a plugin called always that will, as you'd expect, always be loaded.

[1]: https://github.com/junegunn/vim-plug
