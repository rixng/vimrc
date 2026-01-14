let g:fastcmd = {
            \     'normal': {
            \         'batch': v:false,
            \         'config': {},
            \     },
            \     'number': {
            \         'batch': v:false,
            \         'count': 0,
            \     }
            \ }
" 清空环境
function! fastcmd#clean() 
    " 保存当前设置(如果有其他影响的配置项, 需要补充)
    let g:fastcmd.normal.config.runtimepath = &runtimepath
    let g:fastcmd.normal.config.eventignore = &eventignore
    let g:fastcmd.normal.config.filetype    = &filetype
    let g:fastcmd.normal.config.indentexpr  = &indentexpr
    let g:fastcmd.normal.config.foldmethod  = &foldmethod
    let g:fastcmd.normal.config.clipboard   = &clipboard
    let g:fastcmd.normal.config.lazyredraw  = &lazyredraw
    " 清空设置
    set runtimepath=
    set eventignore=all
    set filetype=
    set indentexpr=
    set foldmethod=manual
    set clipboard=
    set lazyredraw
    " number
    let g:fastcmd.number.batch = v:true
    let g:fastcmd.number.count = 0
endfunction

" 恢复环境
function! fastcmd#load()
    " 恢复设置
    let &runtimepath = g:fastcmd.normal.config.runtimepath
    let &eventignore = g:fastcmd.normal.config.eventignore
    let &filetype    = g:fastcmd.normal.config.filetype
    let &indentexpr  = g:fastcmd.normal.config.indentexpr
    let &foldmethod  = g:fastcmd.normal.config.foldmethod
    let &clipboard   = g:fastcmd.normal.config.clipboard
    let &lazyredraw  = g:fastcmd.normal.config.lazyredraw
    " 强制重载文件类型
    if g:fastcmd.normal.config.filetype != ''
        silent! doautocmd FileType
    endif
    " number
    let g:fastcmd.number.batch = v:false
    let g:fastcmd.number.count = 0
endfunction

function! g:fastcmd#normal(line1, line2, command) range
    if !g:fastcmd.normal.batch
        " 清空环境
        call fastcmd#clean()
    endif
    " 执行命令
    try
        if a:command != ''
            execute 'noautocmd ' . a:line1 . ',' . a:line2 .
                        \ 'normal! ' . a:command
        endif
    endtry
    if !g:fastcmd.normal.batch
        " 恢复环境
        call fastcmd#load()
    endif
endfunction

" 查找字符串中第一个非转义的斜杠位置
function! fastcmd#find_param1(str) abort
    let l:len = len(a:str)
    let l:i = 0
    while l:i < l:len
        if a:str[l:i] ==# '\'
            " 跳过转义字符（反斜杠及其下一个字符）
            let l:i += 2
        elseif a:str[l:i] ==# '/'
            " 找到非转义斜杠
            return l:i
        else
            let l:i += 1
        endif
    endwhile
    return -1  " 未找到
endfunction

function! fastcmd#global_normal(global, line1, line2, params) range
    " 必须以斜杠开头
    if a:params[0] !=# '/'
        echo "Error: Command must start with /"
        return
    endif
    " 去掉开头斜杠
    let str = a:params[1:]
    " 查找第一个非转义斜杠
    let idx = fastcmd#find_param1(str)

    if idx == -1
        echo "Error: Missing second slash"
        return
    endif

    let pattern = str[:idx-1]
    let command = str[idx+1:]

    let g:fastcmd.normal.batch = v:true
    call fastcmd#clean()
    execute a:line1 . ',' a:line2 .
          \ a:global . '/' . pattern . '/' . ':Normal ' . command
    call fastcmd#load()
    let g:fastcmd.normal.batch = v:false
endfunction

function! fastcmd#normal_number(params) range
    if mode() ==# 'n'
        let s:count = 1
        if g:fastcmd.number.batch
            let g:fastcmd.number.count = g:fastcmd.number.count + 1
            let s:count = g:fastcmd.number.count
        endif
        execute 'normal! ' . s:count . a:params
    endif
endfunction

" `:Normal {command}`  ==>  `:normal! {command}`
command! -range -nargs=1 Normal call g:fastcmd#normal(<line1>, <line2>, <q-args>)
" `:GNormal/{pattern}/{command}`  ==>  `:g/{pattern}/:normal! {command}`
" 在能被{pattern}匹配的行, 执行{command} (不是{pattern}位置)
command! -range -nargs=1 GNormal call g:fastcmd#global_normal('g', <line1>, <line2>, <q-args>)
" `:VNormal/{pattern}/{command}`  ==>  `:v/{pattern}/:normal! {command}`
" 在不被{pattern}匹配的行, 执行{command}
command! -range -nargs=1 VNormal call g:fastcmd#global_normal('v', <line1>, <line2>, <q-args>)

" Number  在 Normal 中类似递增操作
" 普通模式(每行执行 行数的<C-A>) (:Number {action}<CR>)
"   看起来的样子   :Normal :Number ^A^M
"   mapping的样子  :Normal :Number <C-V><C-A><C-V><CR>
" 插入模式(每行行首插入 行数) (<C-R>=Number()<CR>)
"   看起来的样子   :Normal I^R=Number()^M
"   mapping的样子  :Normal I<C-V><C-R>=Number()<C-V><CR>
command! -nargs=1 Number call fastcmd#normal_number(<q-args>)
function! Number() range
    if mode() !=# 'n'
        let s:count = 1
        if g:fastcmd.number.batch
            let g:fastcmd.number.count = g:fastcmd.number.count + 1
            let s:count = g:fastcmd.number.count
        endif
        return s:count
    endif
endfunction
