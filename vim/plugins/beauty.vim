" 主题
Plug 'sainnhe/everforest'
Plug 'lifepillar/vim-gruvbox8'
Plug 'sainnhe/gruvbox-material'
Plug 'lifepillar/vim-solarized8'
Plug 'nordtheme/vim', { 'as': 'nord' }
Plug 'junegunn/seoul256.vim'
Plug 'ku1ik/vim-monokai'
Plug 'tomasr/molokai'
" vim版的主题
PlugIf 'morhetz/gruvbox', !has('nvim')
PlugIf 'joshdick/onedark.vim', !has('nvim')
PlugIf 'altercation/vim-colors-solarized', !has('nvim')
PlugIf 'catppuccin/vim', !has('nvim'), { 'as': 'cappuccin.vim' }
PlugIf 'nanotech/jellybeans.vim', !has('nvim')
" nvim版本的主题
PlugIf 'ellisonleao/gruvbox.nvim', has('nvim')
PlugIf 'navarasu/onedark.nvim', has('nvim')
PlugIf 'craftzdog/solarized-osaka.nvim', has('nvim')
PlugIf 'catppuccin/nvim', has('nvim'), { 'as': 'catppuccin.nvim' }
PlugIf 'WTFox/jellybeans.nvim', has('nvim')

" nvim独有的主题
PlugIf 'projekt0n/github-nvim-theme', has('nvim')
PlugIf 'xiantang/darcula-dark.nvim', has('nvim')
PlugIf 'folke/tokyonight.nvim', has('nvim')
PlugIf 'rebelot/kanagawa.nvim', has('nvim')
PlugIf 'rose-pine/neovim', has('nvim'), { 'as': 'rose-pine' }
PlugIf 'EdenEast/nightfox.nvim', has('nvim')

PlugIf 'vim-airline/vim-airline', !has('nvim')  " 状态栏
if Plug('vim-airline/vim-airline-themes', !has('nvim'))
    " vim9
    if v:version >= 900
        let g:airline_experimental = 1
    endif
    " 只有一个tab时 显示buffers
    let g:airline#extensions#tabline#enabled = 1
    " 标题仅显示文件名
    let g:airline#extensions#tabline#formatter = 'unique_tail'
endif

if Plug('mhinz/vim-startify', !has('nvim')) " 启动页面
    let g:startify_custom_header = ['']
    let g:startify_lists = [
                \   {'type': 'commands' }, 
                \   {'type': 'files',     'header': [' MRU'],      },
                \   {'type': 'sessions',  'header': []             },
                \   {'type': 'bookmarks', 'header': [' Bookmarks'] },
                \ ]
    let g:startify_files_number = 9
    let g:startify_commands = [
                \   {'n': ['new Typed buffer: 输入文件类型',
                \    'enew | execute "set filetype=".input("filetype=")']},
                \   {'p': ['new Pasted buffer: 粘贴剪切板内容', 
                \    'enew | execute "normal i\<S-Insert>\<Esc>"']},
                \   {'v': ['edit Vimrc: ' . substitute(g:vimrc, '\\', '/', 'g'),
                \    'edit ' . g:vimrc]},
                \ ]

    if has('gui_running')
        let g:startify_commands += [
                    \   {'b': ['font bigger: 调大字体', 'GuiFontBigger']},
                    \   {'s': ['font smaller: 调小字体', 'GuiFontSmaller']},
                    \   {'f': ['full screen: 全屏', 'GuiFullScreen']},
                    \ ]
    endif
endif
