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

" 在普通模式下按<C-a>或<C-x>会对光标所在行的第一个数字进行加减
" 但是vim默认对0开头数字解释为八进制，而不是十进制
" 使用下面设置会让vim将其认为是十进制
" set nrformats = 

" 关于窗口切换的按键映射
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-h> <C-w>h
map <C-l> <C-w>l

" 普通模式下快速移动
nnoremap <Up> 5k
nnoremap <Down> 5j
nnoremap <Left> 5h
nnoremap <Right> 5l

" 缓冲区切换的按键映射 参考自《Vim使用技巧》技巧37中的内容
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>


" 在命令模式下，在底部显示键入的命令
set showcmd
" 在底部显示，当前处于命令模式还是插入模式
set showmode

" 如果行尾有多余的空格(包括tabl),该配置让这些空格显示成可见的小方块
"set listchars=tab:»■,trail:■
set listchars=tab:>-,trail:-
set list

" 不创建交换文件，这样在vim中使用Gstatus就不会看到.swp文件了。
set noswapfile


call plug#begin('~/.vim/plugged')

" 插件管理器 vim-plug，这个需要首先手动下载，但是这里也需要添加
" 不然一旦使用:PlugClan，就会一直报各种错误
Plug 'junegunn/vim-plug'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'kien/rainbow_parentheses.vim'

" 状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes' " airline主题
Plug 'liuchengxu/space-vim-theme' " airline主题
Plug 'dracula/vim' " airline主题


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

" 在命令行显示buf信息
Plug 'bling/vim-bufferline'
" 主题
Plug 'theniceboy/vim-deus'

" vim内部异步执行shell命令，并将结果输出到quickfix列表
Plug 'skywind3000/asyncrun.vim'

call plug#end()

" 解决ultisnips与YCM tab冲突问题
function! g:UltiSnips_Complete()
  call UltiSnips#ExpandSnippet()
  if g:ulti_expand_res == 0
    if pumvisible()
      return "\<C-n>"
    else
      call UltiSnips#JumpForwards()
      if g:ulti_jump_forwards_res == 0
        return "\<TAB>"
      endif
    endif
  endif
  return ""
endfunction

function! g:UltiSnips_Reverse()
  call UltiSnips#JumpBackwards()
  if g:ulti_jump_backwards_res == 0
    return "\<C-P>"
  endif

  return ""
endfunction


if !exists("g:UltiSnipsJumpForwardTrigger")
  let g:UltiSnipsJumpForwardTrigger = "<tab>"
endif
if !exists("g:UltiSnipsJumpBackwardTrigger")
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endif

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger     . " <C-R>=g:UltiSnips_Complete()<cr>"
au InsertEnter * exec "inoremap <silent> " .     g:UltiSnipsJumpBackwardTrigger . " <C-R>=g:UltiSnips_Reverse()<cr>"


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
" 关闭顶部的预览窗口
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

"-------NERDTree-------"
" 设定NERDTree视窗大小
let g:NERDTreeWinSize = 25
" 映射F2打开或关闭NERDTree
map <F2> :NERDTreeToggle<CR>
" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 是否显示行号
let g:NERDTreeShowLineNumbers=1
" 是否显示隐藏文件，有人说开启该功能时在NERDTree窗口中按I可以显示因此文件
" 但是我使用0不开启按I一样可以显示
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

"-------nasyncrun.vim -------"
" 自动打开 quickfix window，高度为6
let g:asyncrun_open = 6
" 设置F10 打开/关闭 Quickfix窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<CR>
" 设置F9 编译单文件
nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 设置F5 运行
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

" 设置主题为deus
colorscheme deus
" 设置airline的启动主题
let g:airline_theme = 'dracula'

" 状态栏显示git信息
let g:airline#extensions#branch#enabled = 1
