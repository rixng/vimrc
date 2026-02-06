" 优先加载

" Leader键
let g:mapleader = ' '
let g:maplocalleader = ' '

" HTTPS  https://github.com/%s.git
" SSH    git@github.com:%s.git
let g:plug_url_format = 'https://github.com/%s.git'

" [0(其他键盘)] [1(60键键盘)]
let g:config_keyboard = 1

" [1] [0]
let g:config_nerdfont = 1

" 选择插件
let g:config_plugins = exists('g:config_plugins') ? g:config_plugins : {}
" [default] [LeaderF] [fzf] [ctrlp-grepper] [fuzzyy]
let g:config_plugins.fuzzy = 'default'

" 加载自定义配置
if !empty(matchlist(resolve(expand('<sfile>:p')), 'gg_example\.vim$')) && filereadable(expand('<sfile>:h') . '/gg.vim')
  source <sfile>:h/gg.vim
endif
