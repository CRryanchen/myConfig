" 不兼容vi
set nocompatible

" Tab键缩进的空格数
set tabstop=4
" 在文本上按下>>，<<时，每一级的字符数,以及按o在下一行的缩进
set shiftwidth=4
" 按下回车键后，下一行缩进会自动跟上一行的缩进保持一致
set autoindent
" 行号显示相关
set relativenumber
" 显示行号
set number
" 光标距离顶部/底部的位置
set scrolloff=10
" 在状态栏显示光标的当前位置

" 关于窗口切换的按键映射
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" 在命令模式下，在底部显示键入的命令
set showcmd
" 在底部显示，当前处于命令模式还是插入模式
set showmode

" 如果行尾有多余的空格(包括tabl),该配置让这些空格显示成可见的小方块
"set listchars=tab:»■,trail:■
set listchars=tab:>-,trail:-
set list


call plug#begin('~/.vim/plugged')

Plug 'junegunn/vim-plug'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'kien/rainbow_parentheses.vim'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-surround'
Plug 'gcmt/wildfire.vim'
Plug 'yegappan/taglist'
Plug 'ycm-core/YouCompleteMe'

" git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'rdolgushin/gitignore.vim'

" snippets
Plug 'Sirver/ultisnips'
Plug 'honza/vim-snippets'



call plug#end()


""""""""""""""""""""""""""""""""
"  			插件配置		   "
""""""""""""""""""""""""""""""""

"-------YouCompleteMe-------"
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
nnoremap <Leader>gi :YcmCompleter GoToInclude<CR>
nnoremap <Leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <Leader>gt :YcmCompleter GoToTo<CR>
nnoremap <Leader>gr :YcmCompleter GoToReferences<CR>

"-------NERDTree-------"
" 设定NERDTree视窗大小
let g:NERDTreeWinSize = 25
" 映射F2打开或关闭NERDTree
map <F2> :NERDTreeToggle<CR>
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 是否显示行号
let g:NERDTreeShowLineNumbers=1
" 是否显示隐藏文件
let g:NERDTreeHidden=1

"-------rainbow_parenthsis-------"
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

" 可配置匹配的括号对数
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
" 打开vim后自动启用
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


"-------nerdcomment-------"
" <leader>cc   加注释
" <leader>cu   解开注释
" <leader>c<space>  加上/解开注释, 智能判断
" <leader>cy   先复制, 再注解(p可以进行黏贴)
" 注释的时候自动加个空格
let g:NERDSpaceDelims = 1



"-------Taglist-------"
" Ctags可执行文件的路径，千万要写对了，否则显示no such file
let Tlist_Ctags_Cmd = '/usr/bin/ctags'   
" 不同时显示多个文件的tag，只显示当前文件的
let Tlist_Show_One_File = 1            
" 如果taglist窗口是最后一个窗口，则退出vim
let Tlist_Exit_OnlyWindow = 1          
" 打开文件时候不自动打开Taglist窗口
let Tlist_Auto_Open=0               
" 在右侧窗口中显示taglist窗口
let Tlist_Use_Right_Window = 1
" 映射F8打开或关闭Taglist
map <F8> :TlistToggle<CR>
" 设置窗口大小
let g:Tlist_WinWidth = 30



"-------wildfire-------"
map <SPACE> <Plug>(wildfire-fuel)
vmap <C-SPACE> <Plug>(wildfire-water)


"-------nerdtree-git-plugin-------"
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?",
    \ }
