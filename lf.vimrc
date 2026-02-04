" 大文件处理 - 关闭一些影响大文件的配置
" 启动 `vim -u NONE`
" 加载 `:source **{Path}**/lf.vimrc`

let g:large_file = 1  " 根据large_file选择加载

source <sfile>:h/autoload/plug.vim
source <sfile>:h/vimrc
