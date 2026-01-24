-- neovide需要配置 --no-multigrid 或配置文件 no-multigrid = true
require('mini.completion').setup()
MiniKeymap.map_multistep('i', '<CR>', { 'pmenu_accept', 'minipairs_cr' })
