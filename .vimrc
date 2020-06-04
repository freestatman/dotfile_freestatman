"  ______                                    __      ___
" |  ____|                                   \ \    / (_)
" | |__ _ __ ___  ___ _ __ ___   __ _ _ __    \ \  / / _ _ __ ___  _ __ ___
" |  __| '__/ _ \/ _ \ '_ ` _ \ / _` | '_ \    \ \/ / | | '_ ` _ \| '__/ __|
" | |  | | |  __/  __/ | | | | | (_| | | | |    \  /  | | | | | | | | | (__
" |_|  |_|  \___|\___|_| |_| |_|\__,_|_| |_|     \/   |_|_| |_| |_|_|  \___|
"
"
" System Setting -----------------------{{{

syntax on
filetype plugin on
filetype indent on
if has("syntax")
    syntax on
endif

retab
set autoread
set autowrite              " Automatically save before command like :next and :make
set background=dark
set clipboard=unnamedplus
set cmdheight=2
set colorcolumn=100
set completeopt=menu
set cursorline             " show the highlight of the current line
set display=uhex
set expandtab
set ffs=unix
set foldmethod=marker
set guicursor=
set guifont=Monaco:h12
set hidden
set history=1000
set hlsearch
set incsearch              " Incremental search
set laststatus=2
set nobackup
set nocompatible
set noerrorbells
set nohlsearch
set noshowmatch
set noswapfile
set nowrap
set nu
set pastetoggle=<F5>
set relativenumber
set ruler                  " show the cursor position all the time
set scrolloff=8
set shiftwidth=4
set showcmd                " Show (partial) command in status line.
set showmatch              " Show matching brackets.
set showtabline=2          " always tabs visible
set smartcase              " Do smart case matching
set smartindent
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set t_Co=256
set tabstop=4 shiftwidth=4 softtabstop=4
set termguicolors
set undodir=~/.vim/undodir
set undofile
set wildmenu

highlight ColorColumn ctermbg=0 guibg=lightgrey

" }}}


" etc {{{

" disable arrow keys
"no <down> ddp
"no <up> ddkP
no <left> <Nop>
no <right> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>

"quick sort within the paragraph
nmap vps vip:sort<CR>

"I really hate that things don't auto-center
nmap G Gzz
nmap N Nzz
nmap n nzz
nmap { {zz
nmap } }zz

" delete surrounding characters
" noremap ss{ F{xf}x
" noremap cs{ F{xf}xi
" noremap cs" F"x,xi
" noremap cs' F'x,xi
" noremap cs( F(xf)xi
" noremap cs) F(xf)xi

"quick quote
nmap <leader>w' ciw'<C-r>"'<ESC>
nmap <leader>w" ciw"<C-r>""<ESC>

"quick equal: transform 'word' ==> 'word=word'
nmap <leader>qe yiwPa=<ESC>ww

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif


" set spell
nmap ss :set spell<CR>
nmap sns :set nospell<CR>


" align code by equal sign
nmap al :Align<- <CR>
vmap vl :Align= <CR>


nmap <leader>al, :Align, <CR>
nmap <leader>al; :Align; <CR>
nmap <leader>al: :Align: <CR>
nmap <leader>al= :Align= <CR>


:ab #b #############################################################################
:ab #l #----------------------------------------------------------------------------
:nmap qq :q!<CR>
:nmap qa :qa<CR>
:imap jj <ESC>
:nmap vv vi{=<CR>
:vmap vv "+y


" Tabs
let g:lasttab = 1
autocmd TabLeave * let g:lasttab = tabpagenr()
nmap ff :exe "tabn ".g:lasttab<CR>   " jungle between tabs

nmap <C-j> :tabnext<CR>
nmap <C-k> :tabprevious<CR>
nmap <C-n> :tabnew <Space>
noremap <F7> :set expandtab!<CR>

" Screen.vim
autocmd FileType sh,txt nmap <Space> V:ScreenSend<CR>j
autocmd FileType sh,txt vmap <Space> :ScreenSend<CR>j
map <F10> :ScreenShellVertical<CR>
let g:ScreenImpl = 'Tmux'

" use nVim-R macros
" Press the space bar to send lines and selection to R:
autocmd FileType R,r,Rmd,rmd map <Space> <leader>lj
autocmd FileType R,r,Rmd,rmd map <F10> <leader>rf


" NERDTree
nmap <leader>ne :NERDTree<cr>
let g:NERDTreeWinPos = "right"


" Source vim script or setting
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>


" substitute
noremap ; :
nnoremap <leader>s :%s///g<left><left>
noremap <leader>pwd :read !pwd<cr>J
noremap <leader>vrc :tabnew ~/.vimrc<cr>
noremap <leader>brc :tabnew ~/.bashrc<cr>
noremap <Leader>rsnp :tabnew ~/.vim/plugged/vim-snippets/snippets/r.snippets<CR>
noremap cp :let @0 = expand("%") <cr>"0p


"get correct json comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

" register
nmap rr :reg<cr>


" lintr via syntastic plugin
let g:syntastic_enable_r_lintr_checker = 0
let g:syntastic_r_checkers = ['lintr']

"remap F1 to Esc for weird keyboard layout
nmap <F1> <nop>
map <F1> <Esc>
imap <F1> <Esc>

"}}}


" plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'chrisbra/Colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/screen'
Plug 'gaalcaras/ncm-R'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'jalvesaq/Nvim-R'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree'
Plug 'ncm2/ncm2'
Plug 'neoclide/coc.nvim', {'branch': 'release'} " needs git v2+
Plug 'roxma/nvim-yarp'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tmhedberg/SimpylFold'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tweekmonster/gofmt.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-scripts/Align'
Plug 'vim-utils/vim-man'

"Plugin 'jcfaria/Vim-R-plugin'
"Plugin 'junegunn/vim-easy-align'
"Plugin 'tpope/vim-commentary'
"Plugin 'valloric/youcompleteme'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'jaxbot/browserlink.vim'

" Vim 8 only
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()
" }}}



" Nvim-R config
let r_syntax_folding = 1
let R_assign=3
let g:r_indent_align_args = 3
let g:r_indent_comment_column = '#'
let g:syntastic_r_checkers = 1
let r_indent_ess_comments = 1
let r_indent_op_pattern = '(+\|-\|\*\|/\|=\|\~\|%\)$'
let vimrplugin_assign = 0

" https://github.com/gvfarns/r_indent_gvf
:autocmd FileType r setlocal indentexpr=RIndent_GVF(v:lnum)


" Commenting blocks of code. {{{
autocmd FileType c,cpp,java,scala   let b:comment_leader = '// '
autocmd FileType sh,ruby,python,R,r let b:comment_leader = "# "
autocmd FileType conf,fstab         let b:comment_leader = "# "
autocmd FileType tex                let b:comment_leader = '% '
autocmd FileType mail               let b:comment_leader = '> '
autocmd FileType vim                let b:comment_leader = '" '
noremap <silent> <C-c> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR> :nohlsearch<CR>
noremap <silent> <C-x> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR> :nohlsearch<CR>
"}}}


" Automations  {{{
" Auto header
" replace all tabs with 4 space when saving the code
"  autocmd bufnewfile,bufwritepre *.r,*.R,*.sh exe "1," . "$" . "s/\t/    /g"
"  autocmd bufwritepre,filewritepre *.r,*.R,*.sh execute "normal mb"
"  autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," . "20" .  "g/Program:.*/s/Program:.*/Program:\t".expand("%")
"  autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/rcode=.*/rcode=".expand("%")
"  autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/sh$/R"
"  autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/rcode=.*/rcode=".expand("%")
"  autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/sh$/R"
"  autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^scode=.*/s/scode=.*/scode=".expand("%")
"  autocmd bufwritepost,filewritepost *.R,*.sh execute "normal `b"
" }}}


" Updating Peer reviewer  {{{
:noremap <leader>cp  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tTBD \\/ ".strftime("%b %d, %Y") <CR>
:noremap <leader>ww  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" .  "g/^#\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")  <CR>
:noremap <leader>nn  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" . "g/^#\\+\\s\\+Peer.*/s/hh/hh/" <CR>
"}}}


" IDE tools {{{
" :noremap <leader>sh  :!sh %:r.sh <CR>
" :noremap <leader>log :!vsp -O LOGS_AND_LISTS/%*log <CR>
" :noremap <leader>er  :!vim -O LOGS_AND_LISTS/%*er <CR>
"" grep i/o files in R script
" :noremap <C-i> :!~/grep_io_files.sh % <CR><CR>:vsp ~/tmp_io_file.R<CR><C-w>R<ESC>

autocmd FileType sh nmap <buffer> <Leader>h "zyiw :call ScreenShellSend("echo $".@z ."")<CR>
autocmd FileType sh nmap <buffer> <Leader>l "zyiw :call ScreenShellSend("log ".@z ."")<CR>
"nmap <Leader>h "zyiw :call ScreenShellSend("echo $".@z ."")<CR>
"nmap <Leader>l "zyiw :call ScreenShellSend("log ".@z ."")<CR>


" tags {{{
autocmd FileType r,rnoweb set tags+=~/.vim/RTAGS,~/.vim/RsrcTags
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()
"}}}



" Twiddle Case ----------------------------{{{
" capitalized the first Letter
map cc b~el

function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv)
"}}}


" Highlighted color for specific part {{{
hi Search cterm=NONE ctermfg=grey ctermbg=blue
"}}}


" System mappings 2017 (from Mike) ----------------------------------------------------------{{{
" repo  : https://github.com/mhartington/dotfiles/

" No need for ex mode
nnoremap Q <nop>
" recording macros is not my thing
map q <Nop>

inoremap <c-f> <c-x><c-f>
" Copy to osx clipboard (maynot work for Linux env)
"  vnoremap <C-c> "*y<CR>
"  vnoremap y "*y<CR>
"  nnoremap Y "*Y<CR>

let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<Esc>'

"}}}


"Nvim-R tricks{{{
"

autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif


" Use Ctrl+Space to do omnicompletion:
if has('nvim') || has('gui_running')
    inoremap <C-Space> <C-x><C-o>
else
    inoremap <Nul> <C-x><C-o>
endif



" The plugin also contains a function called RAction which allows you to build
" ad-hoc commands to R. This function takes the name of an R function such as
" "levels" or "table" and the word under the cursor, and passes them to R as a
" command.

nmap <silent> <LocalLeader>h :call RAction("head", "@,48-57,_,.")<CR>
vmap <silent> <LocalLeader>h :call RAction("head", "v")<CR>
nmap <silent> <LocalLeader>g :call RAction("glimpse")<CR>
nmap <silent> <LocalLeader>t :call RAction("tail")<CR>
nmap <silent> <LocalLeader>n :call RAction("names")<CR>
nmap <silent> <LocalLeader>l :call RAction("length")<CR>
nmap <silent> <LocalLeader>d :call RAction("dim")<CR>
nmap <silent> <LocalLeader>lv :call RAction("levels")<CR>
"nmap <silent> <LocalLeader>H :call RAction("head")<CR>
"map <silent> <LocalLeader>s :call g:SendCmdToR("search()")<CR>

" The era prior to Nvim-R
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>h "zyiw :call ScreenShellSend("head(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>g "zyiw :call ScreenShellSend("glimpse(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>r "zyiw :call ScreenShellSend("tbl_df(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>t "zyiw :call ScreenShellSend("tail(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>d "zyiw :call ScreenShellSend("dim(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>l "zyiw :call ScreenShellSend("length(".@z .")")<CR>
" autocmd FileType r,R,rmd,Rmd  nmap <Leader>n "zyiw :call ScreenShellSend("names(".@z .")")<CR>


"}}}



" R code specific {{{

" Trying to write a vim function to format R codes
"function formatR(wmsg)
"vmap fmt :!w ~/formatR_dat.R <CR><CR>:!cd ~<CR><CR>:!R --vanilla --slave --args $file=formatR_dat.R < /home/swa/formatR_run.R <CR><CR> :vsp ~/formatR_out.R<CR><C-w>R<ESC>
"vmap fmt :!w ~/formatR_dat.R <CR><CR>:vsp ~/formatR_dat.R<CR><C-w>R<ESC>
"endfunction

"}}}


if executable('rg')
    let g:rg_derive_root='true'
endif

let mapleader='\'
nmap <Space> <leader>   " try Space as new leader key
let loaded_matchparen = 1
let g:netrw_browse_split = 2
let g:vrfr_rg = 'true'
let g:netrw_banner = 0
let g:netrw_winsize = 25

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
nnoremap <leader>u :UndotreeShow<CR>
nnoremap <leader>pv :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <Leader>ps :Rg<SPACE>
nnoremap <C-p> :GFiles<CR>
nnoremap <Leader>pf :Files<CR>
nnoremap <Leader><CR> :so ~/.config/nvim/init.vim<CR>
nnoremap <Leader>+ :vertical resize +5<CR>
nnoremap <Leader>- :vertical resize -5<CR>
nnoremap <Leader>ee oif err != nil {<CR>log.Fatalf("%+v\n", err)<CR>}<CR><esc>kkI<esc>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv



" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>rr <Plug>(coc-rename)
nmap <leader>g[ <Plug>(coc-diagnostic-prev)
nmap <leader>g] <Plug>(coc-diagnostic-next)
nmap <silent> <leader>gp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>gn <Plug>(coc-diagnostic-next)
nnoremap <leader>cr :CocRestart


" Sweet Sweet FuGITive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

autocmd BufWritePre * :call TrimWhitespace()




