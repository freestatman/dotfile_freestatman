"  ______                                    __      ___                    
" |  ____|                                   \ \    / (_)                   
" | |__ _ __ ___  ___ _ __ ___   __ _ _ __    \ \  / / _ _ __ ___  _ __ ___ 
" |  __| '__/ _ \/ _ \ '_ ` _ \ / _` | '_ \    \ \/ / | | '_ ` _ \| '__/ __|
" | |  | | |  __/  __/ | | | | | (_| | | | |    \  /  | | | | | | | | | (__ 
" |_|  |_|  \___|\___|_| |_| |_|\__,_|_| |_|     \/   |_|_| |_| |_|_|  \___|
" 	                                                                              
" System Setting -----------------------{{{

syntax on
:set pastetoggle=<F5>
set guifont=Monaco:h12

" set smartindent
" set autoindent
" set showtabline=2  " always tabs visible
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
"set mouse=a        " Enable mouse usage (all modes)
"set ttymouse=xterm2
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

set autoread

" }}}

"remap F1 to Esc for weird keyboard layout
:nmap <F1> <nop>
map <F1> <Esc>
imap <F1> <Esc>

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

"snippet related plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'} " needs git v2+
" Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'} 
" Plug 'neoclide/coc.nvim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'vim-pandoc/vim-rmarkdown'
Plug 'vim-scripts/Align'
Plug 'ekalinin/Dockerfile.vim'
Plug 'jalvesaq/Nvim-R'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
Plug 'chrisbra/Colorizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/screen'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'tmhedberg/SimpylFold'
Plug 'scrooloose/nerdcommenter'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'gaalcaras/ncm-R'

"Plugin 'jcfaria/Vim-R-plugin'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'junegunn/vim-easy-align'
"Plugin 'mattn/emmet-vim'
"Plugin 'pangloss/vim-javascript'
"Plugin 'tomtom/tlib_vim'
"Plugin 'tpope/vim-commentary'
"Plugin 'tpope/vim-fugitive'
"Plugin 'valloric/youcompleteme'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-syntastic/syntastic'
"Plugin 'jaxbot/browserlink.vim'

" Vim 8 only
if !has('nvim')
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Optional: for snippet support
" Further configuration might be required, read below
" Plugin 'sirver/UltiSnips'
" Plugin 'ncm2/ncm2-ultisnips'


" All of your Plugins must be added before the following line
call plug#end()            " required
" }}}



" Nvim-R config
"let r_indent_op_pattern = '\(+\|-\|\*\|/\|=\|\~\|%\)$'
"let g:r_indent_op_pattern = '%[^%]*%$'
"
let R_assign=3
set expandtab
set shiftwidth=4
let r_indent_ess_comments = 1
let g:r_indent_align_args = 3
let g:r_indent_comment_column = '#'

" https://github.com/gvfarns/r_indent_gvf
:autocmd FileType r setlocal indentexpr=RIndent_GVF(v:lnum)

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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


autocmd FileType sh nmap <Leader>h "zyiw :call ScreenShellSend("echo $".@z ."")<CR>
autocmd FileType sh nmap <Leader>l "zyiw :call ScreenShellSend("log ".@z ."")<CR>
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
:vmap vv "+y


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
autocmd FileType sh,txt nmap <Space> V:ScreenSend<CR>j
autocmd FileType sh,txt vmap <Space> :ScreenSend<CR>j

"nmap <F9> V:ScreenSend<CR>j
"vmap <Space> :ScreenSend<CR>j
"map <F10> :ScreenShellVertical<CR>oqA<Esc>V:ScreenSend<CR>VsR<Esc>V:ScreenSend<CR>dd
"map <F10> :ScreenShellVertical<CR>VsR<Esc>V:ScreenSend<CR>dd
map <F10> :ScreenShellVertical<CR>
let g:ScreenImpl = 'Tmux'

" use nVim-R macros
" Press the space bar to send lines and selection to R:
" autocmd FileType R,r,Rmd,rmd vmap <Space> <Plug>RDSendSelection
" autocmd FileType R,r,Rmd,rmd nmap <Space> <Plug>RDSendLine
autocmd FileType R,r,Rmd,rmd map <Space> <leader>lj
autocmd FileType R,r,Rmd,rmd map <F10> <leader>rf


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
noremap <Leader>rsnp :tabnew ~/.vim/plugged/vim-snippets/snippets/r.snippets<CR>

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
" xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)


"----------------------------------------------------------------------------
" lintr via syntastic plugin
"----------------------------------------------------------------------------
let g:syntastic_enable_r_lintr_checker = 0
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

" copy current files path to reg 0 and paste at the current cursor
nmap cp :let @0 = expand("%") <cr>"0p 


" clipboard
set clipboard=unnamedplus

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

"get correct json comment highlighting
autocmd FileType json syntax match Comment +\/\/.\+$+

"coc.vim README config{{{
"
"  " if hidden is not set, TextEdit might fail.
"  set hidden
"
"  " Some servers have issues with backup files, see #649
"  set nobackup
"  set nowritebackup
"
"  " Better display for messages
"  set cmdheight=2
"
  " You will have bad experience for diagnostic messages when it's default 4000.
  set updatetime=300
"
"  " don't give |ins-completion-menu| messages.
"  set shortmess+=c
"
"  " always show signcolumns
"  set signcolumn=yes
"
"  " Use tab for trigger completion with characters ahead and navigate.
"  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"  inoremap <silent><expr> <TAB>
"        \ pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ coc#refresh()
"  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
"  function! s:check_back_space() abort
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~# '\s'
"  endfunction
"
"  " Use <c-space> to trigger completion.
"  inoremap <silent><expr> <c-space> coc#refresh()
"
"  " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"  " Coc only does snippet and additional edit on confirm.
"  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"  " Or use `complete_info` if your vim support it, like:
"  " inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
"
"  " Use `[g` and `]g` to navigate diagnostics
"  nmap <silent> [g <Plug>(coc-diagnostic-prev)
"  nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"  " Remap keys for gotos
"  nmap <silent> gd <Plug>(coc-definition)
"  nmap <silent> gy <Plug>(coc-type-definition)
"  nmap <silent> gi <Plug>(coc-implementation)
"  nmap <silent> gr <Plug>(coc-references)
"
"  " Use K to show documentation in preview window
"  nnoremap <silent> K :call <SID>show_documentation()<CR>
"
"  function! s:show_documentation()
"    if (index(['vim','help'], &filetype) >= 0)
"      execute 'h '.expand('<cword>')
"    else
"      call CocAction('doHover')
"    endif
"  endfunction
"
"  " Highlight symbol under cursor on CursorHold
"  autocmd CursorHold * silent call CocActionAsync('highlight')
"
"  " Remap for rename current word
"  nmap <leader>rn <Plug>(coc-rename)
"
"  " Remap for format selected region
"  xmap <leader>f  <Plug>(coc-format-selected)
"  nmap <leader>f  <Plug>(coc-format-selected)
"
"  augroup mygroup
"    autocmd!
"    " Setup formatexpr specified filetype(s).
"    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"    " Update signature help on jump placeholder
"    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"  augroup end
"
"  " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
"  xmap <leader>a  <Plug>(coc-codeaction-selected)
"  nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"  " Remap for do codeAction of current line
"  nmap <leader>ac  <Plug>(coc-codeaction)
"  " Fix autofix problem of current line
"  nmap <leader>qf  <Plug>(coc-fix-current)
"
"  " Create mappings for function text object, requires document symbols feature of languageserver.
"  xmap if <Plug>(coc-funcobj-i)
"  xmap af <Plug>(coc-funcobj-a)
"  omap if <Plug>(coc-funcobj-i)
"  omap af <Plug>(coc-funcobj-a)
"
"  " Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
"  nmap <silent> <C-d> <Plug>(coc-range-select)
"  xmap <silent> <C-d> <Plug>(coc-range-select)
"
"  " Use `:Format` to format current buffer
"  command! -nargs=0 Format :call CocAction('format')
"
"  " Use `:Fold` to fold current buffer
"  command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"  " use `:OR` for organize import of current buffer
"  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
"
"  " Add status line support, for integration with other plugin, checkout `:h coc-status`
"  set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"  " Using CocList
"  " Show all diagnostics
"  nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"  " Manage extensions
"  nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"  " Show commands
"  nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"  " Find symbol of current document
"  nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"  " Search workspace symbols
"  nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"  " Do default action for next item.
"  nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"  " Do default action for previous item.
"  nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"  " Resume latest coc list
"  nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

"}}}
                                                        
