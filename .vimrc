"  ______                                    __      ___                    
" |  ____|                                   \ \    / (_)                   
" | |__ _ __ ___  ___ _ __ ___   __ _ _ __    \ \  / / _ _ __ ___  _ __ ___ 
" |  __| '__/ _ \/ _ \ '_ ` _ \ / _` | '_ \    \ \/ / | | '_ ` _ \| '__/ __|
" | |  | | |  __/  __/ | | | | | (_| | | | |    \  /  | | | | | | | | | (__ 
" |_|  |_|  \___|\___|_| |_| |_|\__,_|_| |_|     \/   |_|_| |_| |_|_|  \___|
" 	                                                                              
" System Setting -----------------------{{{

    syntax on
    :set pastetoggle=<f5>
    set guifont=Monaco:h12

    " set smartindent
    " set autoindent
    " set showtabline=2  " always tabs visible
    set expandtab
    set tabstop=4
    set shiftwidth=4
    set softtabstop=4
    set mouse=a        " Enable mouse usage (all modes)
    set ttymouse=xterm2
    set cindent
    set cursorline        " show the highlight of the current line
    set ruler        " show the cursor position all the time

    set nocompatible
    syntax enable
    filetype plugin on
    filetype indent on

    if has("syntax")
     syntax on
    endif

    " The following are commented out as they cause vim to behave a lot
    set showcmd        " Show (partial) command in status line.
    set showmatch        " Show matching brackets.
    set ignorecase        " Do case insensitive matching
    set smartcase        " Do smart case matching
    set incsearch        " Incremental search
    set autowrite        " Automatically save before command like :next and :make
    set hlsearch

    set showtabline=2  " always tabs visible
    " set mouse=a        " Enable mouse usage (all modes)

    set foldmethod=marker
" }}}


" Vunde {{{
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Bundle 'altercation/vim-colors-solarized'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'ascenator/L9', {'name': 'newL9'}
Plugin 'chrisbra/Colorizer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/screen'
Plugin 'garbas/vim-snipmate'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'honza/vim-snippets'
Plugin 'junegunn/vim-easy-align'
Plugin 'mattn/emmet-vim'
Plugin 'pangloss/vim-javascript'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/nerdtree'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
" Plugin 'valloric/youcompleteme'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-syntastic/syntastic'
Plugin 'jaxbot/browserlink.vim'
Plugin 'tmhedberg/SimpylFold'


" All of your Plugins must be added before the following line
call vundle#end()            " required
" }}}


" Color and font {{{

"============== Color Settings ===============
set t_Co=256
set background=dark
" color desert
" color mod8
" color mango
" color mango
" color codeschool
" color southernlights
" color tango
" color desertink
" color wombat256
" color xterm16
" color railscasts
" color skittles_dark

"}}}


" Commenting blocks of code. {{{
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python,R let b:comment_leader = '# '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
noremap <silent> <C-c> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR> :nohlsearch<CR>
noremap <silent> <C-x> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR> :nohlsearch<CR>

"}}}


" Automations  {{{

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" replace all tabs with 4 space when saving the code
autocmd bufnewfile,bufwritepre *.R,*.sh exe "1," . "$" . "s/\t/    /g"
autocmd bufwritepre,filewritepre *.r,*.R,*.sh execute "normal mb"
" autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," . "20" .  "g/Program:.*/s/Program:.*/Program:\t".expand("%")
autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/rcode=.*/rcode=".expand("%")
autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/sh$/R"
autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/rcode=.*/rcode=".expand("%")
autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^rcode=.*/s/sh$/R"
autocmd bufnewfile,Bufwritepre *.sh exe "1," . "$" . "g/^scode=.*/s/scode=.*/scode=".expand("%")
autocmd bufwritepost,filewritepost *.R,*.sh execute "normal `b"

" }}}


" Updating Peer reviewer  {{{
:noremap <leader>cp  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tTBD \\/ ".strftime("%b %d, %Y") <CR>
:noremap <leader>ww  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" .  "g/^#\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")  <CR>
:noremap <leader>nn  :autocmd bufnewfile,Bufwritepre *.r,*.R,*.sh exe "1," .  "$" . "g/^#\\+\\s\\+Peer.*/s/hh/hh/" <CR>
"}}}


" IDE tools {{{
:noremap <leader>sh  :!sh %:r.sh <CR>
":noremap <leader>log :!vsp -O LOGS_AND_LISTS/%*log <CR>
":noremap <leader>er  :!vim -O LOGS_AND_LISTS/%*er <CR>

"" grep i/o files in R script
:noremap <C-i> :!~/grep_io_files.sh % <CR><CR>:vsp ~/tmp_io_file.R<CR><C-w>R<ESC>


autocmd FileType sh nmap <Leader>h "zyiw :call ScreenShellSend("echo $".@z ."")<CR>
autocmd FileType sh nmap <Leader>l "zyiw :call ScreenShellSend("log ".@z ."")<CR>
"nmap <Leader>h "zyiw :call ScreenShellSend("echo $".@z ."")<CR>
"nmap <Leader>l "zyiw :call ScreenShellSend("log ".@z ."")<CR>

autocmd FileType r,R  nmap <Leader>h "zyiw :call ScreenShellSend("head(".@z .")")<CR>
autocmd FileType r,R  nmap <Leader>r "zyiw :call ScreenShellSend("tbl_df(".@z .")")<CR>
autocmd FileType r,R  nmap <Leader>t "zyiw :call ScreenShellSend("tail(".@z .")")<CR>
autocmd FileType r,R  nmap <Leader>d "zyiw :call ScreenShellSend("dim(".@z .")")<CR>
autocmd FileType r,R  nmap <Leader>l "zyiw :call ScreenShellSend("length(".@z .")")<CR>
autocmd FileType r,R  nmap <Leader>n "zyiw :call ScreenShellSend("names(".@z .")")<CR>

" awesome updated version of \h
"nmap <Leader>h "zyiw :call ScreenShellSend("as_data_frame(".@z .")")<CR>
"nmap <Leader>h "zyiw :call ScreenShellSend("head(".@z .")")<CR>
"nmap <Leader>d "zyiw :call ScreenShellSend("dim(".@z .")")<CR>
"nmap <Leader>r "zyiw :call ScreenShellSend("tbl_df(".@z .")")<CR>
"nmap <Leader>l "zyiw :call ScreenShellSend("length(".@z .")")<CR>
"nmap <Leader>H "zyiw :call ScreenShellSend( "write.table(head(".@z .", 3), file=file.path('~/tmpo.txt'), row.names=T, sep='\\t', quote=FALSE)" )<CR> :read ~/tmpo.txt<CR>V3j<C-c><CR>
autocmd FileType R,r  nmap <Leader>H "zyiw :call ScreenShellSend( "write.table(head(".@z .", 3), file=file.path('~/tmpo.txt'), row.names=T, sep='\\t', quote=FALSE)" )<CR> :read ~/tmpo.txt<CR>V3j<C-c><CR>

"nmap <Leader>h "zyiw :call ScreenShellSend("head(".@z .", 2)")<CR>
"nmap <Leader>t "zyiw :call ScreenShellSend("tail(".@z .", 2)")<CR>
"nmap <Leader>d "zyiw :call ScreenShellSend("dim(".@z .")")<CR>
"nmap <Leader>l "zyiw :call ScreenShellSend("length(".@z .")")<CR>
"nmap <Leader>n "zyiw :call ScreenShellSend("names(".@z .")")<CR>
"}}}


" tags {{{
autocmd FileType r,rnoweb set tags+=~/.vim/RTAGS,~/.vim/RsrcTags

function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction
autocmd VimEnter * call StartUp()
"}}}


" Powerline {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Project vimrc file. To be sourced each time you open any file in this
" repository. You may use [vimscript #3393][1] [(homepage)][2] to do this
" automatically.
"
" [1]: http://www.vim.org/scripts/script.php?script_id=3393
" [2]: https://github.com/thinca/vim-localrc
"setlocal noexpandtab
" Despite promise somewhere alignment is done only using tabs. Thus setting
" &tabstop is a requirement.
"setlocal tabstop=4
"let g:syntastic_python_flake8_args = '--ignore=W191,E501,E121,E122,E123,E128,E225,W291,E126'
"let b:syntastic_checkers = ['flake8']
"}}}


" Sets, maps,lets {{{
set wildmenu
set cmdheight=2
set display=uhex
set completeopt=menu
set noexpandtab
set history=1000
"set list listchars=trail:-,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set ffs=unix

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



"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" delete surrounding characters
" noremap ss{ F{xf}x
" noremap cs{ F{xf}xi
" noremap cs" F"x,xi
" noremap cs' F'x,xi
" noremap cs( F(xf)xi
" noremap cs) F(xf)xi

nmap cu ct_
nmap cU cf_

"quick pairs
imap <leader>' ''<ESC>i
imap <leader>" ""<ESC>i
imap <leader>( ()<ESC>i
imap <leader>[ []<ESC>i

"quick quote
nmap <leader>w' ciw'<C-r>"'<ESC>
nmap <leader>w" ciw"<C-r>""<ESC>

"quick equal: transform 'word' ==> 'word=word'
nmap qe yiwPa=<ESC>ww

let mapleader='\'
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"let g:Powerline_symbols = 'fancy'
"call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')


" set spell
nmap ss :set spell<CR>
nmap sns :set nospell<CR>


" align
nmap al :Align<- <CR>
vmap vl :Align= <CR>
nmap fmt :exe "g/[^ ]<-[^ ]/s/<-/ <- /"<CR>

nmap <leader>al, :Align, <CR>
nmap <leader>al; :Align; <CR>
nmap <leader>al: :Align: <CR>
nmap <leader>al= :Align= <CR>


" Trying to write a vim function to format R codes
"function formatR(wmsg)
"vmap fmt :!w ~/formatR_dat.R <CR><CR>:!cd ~<CR><CR>:!R --vanilla --slave --args $file=formatR_dat.R < /home/swa/formatR_run.R <CR><CR> :vsp ~/formatR_out.R<CR><C-w>R<ESC>
"vmap fmt :!w ~/formatR_dat.R <CR><CR>:vsp ~/formatR_dat.R<CR><C-w>R<ESC>
"endfunction


:ab #b #############################################################################
:ab #l #----------------------------------------------------------------------------
:nmap qq :q!<CR>
:nmap qa :qa<CR>
:imap jj <ESC>
:nmap vv vi{=<CR>
:nmap vv "*y


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lasttab = 1
autocmd TabLeave * let g:lasttab = tabpagenr()
nmap ff :exe "tabn ".g:lasttab<CR>   " jungle between tabs

nmap <C-j> :tabnext<CR>
nmap <C-k> :tabprevious<CR>
nmap <C-n> :tabnew  
noremap <F7> :set expandtab!<CR>

"----------------------------------------------------------------------------
" Screen.vim
nmap <F9> V:ScreenSend<CR>j
vmap <F9> :ScreenSend<CR>j
" map <F10> :ScreenShellVertical<CR>oqA<Esc>V:ScreenSend<CR>VsR<Esc>V:ScreenSend<CR>dd
map <F10> :ScreenShellVertical<CR>VsR<Esc>V:ScreenSend<CR>dd
let g:ScreenImpl = 'Tmux'


" NERDTree
nmap <leader>ne :NERDTree<cr>
let g:NERDTreeWinPos = "right"

noremap ; :

" Source
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" substitute
nnoremap <leader>s :%s///g<left><left>
noremap <leader>pwd :read !pwd<cr>J
noremap <leader>vrc :tabnew ~/.vimrc<cr>
noremap <leader>brc :tabnew ~/.bashrc<cr>
noremap <Leader>rsnp :tabnew ~/.vim/snippets/r.snippets<CR>

"----------------------------------------------------------------------------
"set tab to space
"----------------------------------------------------------------------------
setlocal tabstop=4
set shiftwidth=4
set expandtab
retab
set tabstop=4 shiftwidth=4 expandtab

" register
nmap rr :reg<cr>

" R
let g:syntastic_r_checkers = 1
let r_syntax_folding = 1
let r_indent_op_pattern = '(+\|-\|\*\|/\|=\|\~\|%\)$'
let vimrplugin_assign = 0


"----------------------------------------------------------------------------
" easyAlign
"----------------------------------------------------------------------------
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)


"----------------------------------------------------------------------------
" lintr via syntastic plugin
"----------------------------------------------------------------------------
let g:syntastic_enable_r_lintr_checker = 1
" let g:syntastic_r_checkers = ['lintr']

"}}}


" Twiddle Case ----------------------------{{{
" capitalized the first letter
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
"hi Comment term=bold ctermfg=Cyan guifg=#80a0ff gui=bold
hi Search cterm=NONE ctermfg=grey ctermbg=blue
"}}}


" System mappings 2017 (from Mike) ----------------------------------------------------------{{{
" repo  : https://github.com/mhartington/dotfiles/

" No need for ex mode
  nnoremap Q <nop>
" recording macros is not my thing
  map q <Nop>

" copy current files path to clipboard
  nmap cp :let @+ = expand("%") <cr>

  inoremap <c-f> <c-x><c-f>
" Copy to osx clipboard
  vnoremap <C-c> "*y<CR>
  vnoremap y "*y<CR>
  nnoremap Y "*Y<CR>
  let g:multi_cursor_next_key='<C-n>'
  let g:multi_cursor_prev_key='<C-p>'
  let g:multi_cursor_skip_key='<C-x>'
  let g:multi_cursor_quit_key='<Esc>'

"}}}

