" PlugVim加载插件
function! Plug(repo, cond, ...)
    let opts = get(a:000, 0, {})
    call plug#(a:repo, a:cond ? opts : extend(opts, { 'on': [], 'for': [] }))
    return a:cond
endfunction
command! -nargs=+ -bar PlugIf call Plug(<args>)

call plug#begin(g:vimdir . '/plugged')
Source vim/plugins/basic.vim
Source vim/plugins/filetree.vim
Source vim/plugins/git.vim
Source vim/plugins/beauty.vim
Source vim/plugins/fuzzy.vim
Source vim/plugins/coc.vim
Source vim/plugins/languages.vim

PlugIf 'folke/lazy.nvim', has('nvim')
" if Plug('nvim-mini/mini.nvim', has('nvim') && v:true)
"     call plug#load('mini.nvim')
"     lua require('configs.mini')
" endif
call plug#end()

if has('nvim')
    lua require('configs.lazy')
endif