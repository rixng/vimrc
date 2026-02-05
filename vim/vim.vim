" 上移下移
nnoremap <silent> <C-S-Up>   <Esc>:<C-U>m--<CR>
nnoremap <silent> <C-S-Down> <Esc>:<C-U>m+<CR>
xnoremap <silent> <C-S-Up>   :m '<--<CR>gv=gv
xnoremap <silent> <C-S-Down> :m '>+<CR>gv=gv

" 切换 buffer or tag
nnoremap <silent> <A-Left>  <Esc>:<C-U>call GotoPrevPage()<CR>
nnoremap <silent> <A-Right> <Esc>:<C-U>call GotoNextPage()<CR>
function! GotoNextPage()
    if tabpagenr('$') == 1
        bnext
    else
        tabnext
    endif
endfunction

function! GotoPrevPage()
    if tabpagenr('$') == 1
        bprevious
    else
        tabprevious
    endif
endfunction

" Terminal
nnoremap <Leader>t <CMD>botright terminal ++rows=5<CR>

" GUI command
if has('gui_running')
    " 调大字体
    command! GuiFontBigger  let &guifont = substitute(&guifont, '\d\+$', '\=str2nr(submatch(0)) + 1', '')
    " 调小字体
    command! GuiFontSmaller let &guifont = substitute(&guifont, '\d\+$', '\=str2nr(submatch(0)) - 1', '')
    " 全屏
    command! GuiFullScreen simalt ~x
endif

" IME
if has('multi_byte_ime')
    augroup IME
        autocmd!
        autocmd VimEnter * set imdisable | set noimdisable
    augroup END
endif

command! LargeFile call LargeFile()
function! LargeFile()
    " 搜索慢
    set shortmess+=S
    let g:airline_extensions = []
endfunction
