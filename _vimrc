set shell=powershell
set shellcmdflag=/c
set compatible

nmap <Leader>vrc :tabnew ~/_vimrc<CR>

" neovim
if has('nvim')
    let s:editor_root=expand("~\config\nvim")
    nmap <Leader>vrc :tabnew ~\AppData\Local\nvim\init.vim<CR>
else
    let s:editor_root=expand("~\vimfiles")
    nmap <Leader>vrc :tabnew ~\_vimrc<CR>
endif



if has("syntax")
  syntax on
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

if has("autocmd")
  filetype plugin indent on
endif

set showcmd     " Show (partial) command in status line.
set showmatch       " Show matching brackets.
"set ignorecase     " Do case insensitive matching
set smartcase       " Do smart case matching
set incsearch       " Incremental search
set autowrite       " Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
"set mouse=a        " Enable mouse usage (all modes)
set number
"set history=50     " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set cursorline      " show the highlight of the current line
set cindent

set nocompatible
syntax enable
filetype plugin on
filetype indent on

" Vundle stuff
set rtp+=$HOME/vimfiles/bundle/Vundle.vim
set rtp+=$HOME/.fzf
call vundle#begin('$USERPROFILE/vimfiles/bundle/')
"alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

"let Vundle manage Vundle, required
Plugin 'git@github.com:vim-pandoc/vim-rmarkdown.git'
Plugin 'git@github.com:VundleVim/Vundle.vim.git'
Plugin 'git@github.com:tpope/vim-fugitive.git'
"Plugin 'scrooloose/syntastic'
"Plugin 'easymotion/vim-easymotion'
Plugin 'git@github.com:guns/xterm-color-table.vim.git'
Plugin 'git@github.com:vim-airline/vim-airline.git'
Plugin 'git@github.com:myusuf3/numbers.vim.git'
Plugin 'git@github.com:kien/ctrlp.vim.git'

Plugin 'git@github.com:mattn/emmet-vim.git'
Plugin 'git@github.com:chrisbra/Colorizer.git'
Plugin 'git@github.com:tpope/vim-surround.git'
Plugin 'git@github.com:pangloss/vim-javascript.git'
Plugin 'git@github.com:1995eaton/vim-better-javascript-completion.git'
Plugin 'git@github.com:elzr/vim-json.git'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax' 

"nmap <f3> :NumbersToggle<CR>
"nmap <f4> :NumbersOnOff<CR>

"All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required



" Mapping

"let g:rplugin_tmpdir = "C:\\Users\\swa\\AppData\\Local\\Temp"
let vimrplugin_i386 = 1
let vimrplugin_r_path = "C:\\Program Files\\R\\R-3.3.2\\bin\\i386"
map <F2> <Plug>RStart
"map <F4> <Plug>RClose
"map <F3> <Plug>RSaveClose
"map <F5> <Plug>RArgs
"map <F8> <Plug>RSendFile

"map <F9> <Plug>RSendLine<CR>
vmap <F9> <Plug>RSendLine<Esc><CR>
map <F9> V<Plug>RSendSelection<Esc><CR>
map <F10> V<Plug>RSendSelection<Esc><CR>
"map <F12> <Plug>RSendParagraph

map <silent> <LocalLeader>t :call RAction("tail")<CR>
map <silent> <LocalLeader>r :call RAction("tbl_df")<CR>
map <silent> <LocalLeader>h :call RAction("head")<CR>
map <silent> <LocalLeader>dm :call RAction("dim")<CR>
map <silent> <LocalLeader>g :call RAction("glimpse")<CR>
map <silent> <LocalLeader>l :call RAction("length")<CR>
map <silent> <LocalLeader>n :call RAction("names")<CR>
map <silent> <LocalLeader>d :call RAction("dim")<CR>

" Commenting blocks of code.
autocmd FileType c,cpp,java,scala let b:comment_leader = '// '
autocmd FileType sh,ruby,python,R let b:comment_leader = '##  '
autocmd FileType conf,fstab       let b:comment_leader = '# '
autocmd FileType tex              let b:comment_leader = '% '
autocmd FileType mail             let b:comment_leader = '> '
autocmd FileType vim              let b:comment_leader = '" '
autocmd FileType sas          let b:comment_leader = '* '
autocmd FileType bat          let b:comment_leader = ':: '
noremap <silent> <C-c> :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <C-x> :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

:iabbr #b #################################################
:iabbr #l #------------------------------------------------
:imap jj <ESC>
:vmap vv "*y
:nmap vv vi{=<CR>
:nmap qq :q!<CR>
:nmap qa :qa<CR>

set hlsearch
map <F7> mzgg=G'z<CR>


" set font and colorscheme
" colo torte
" colo candy
colo desertink
set guifont=Courier_New:h11:cANSI


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" convert Tabs to white spaces
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set tabstop=4
"set softtabstop=0 noexpandtab
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tabs
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lasttab = 1
autocmd TabLeave * let g:lasttab = tabpagenr()
nmap ff :exe "tabn ".g:lasttab<CR>

nmap <C-j> :tabnext<CR>
nmap <C-k> :tabprevious<CR>
nmap <C-n> :tabnew  
imap <C-k> <ESC>:tabprevious<CR>
imap <C-j> <ESC>:tabnext<CR>
imap <C-n> <ESC>:tabnew  
noremap <F7> :set expandtab!<CR>

nmap <Leader>brc :tabnew ~/_bashrc<CR>
nmap <Leader>rsnp :tabnew ~/vimfiles/snippets/r.snippets<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Auto header
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd bufnewfile *.R so ~/r_header_takeda.txt
autocmd bufwritepre,filewritepre *.R,*.sas,*.bat execute "normal mb"
autocmd bufnewfile,bufwritepre *.R,*.sh,*.sas exe "1," . "40" . "g/Program:.*/s/Program:.*/Program:\t".expand("%")
autocmd bufnewfile,bufwritepre *.sh exe "1," . "$" . "g/^file=.*/s/file=.*/file=".expand("%")
autocmd bufnewfile,bufwritepre *.sh exe "1," . "$" . "g/^file=.*/s/sh$/R"
autocmd bufnewfile,bufwritepre *.R,*.sh,*bat exe "1," . "$" . "g/^#\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.sas exe "1," . "$" . "g/^*\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.R,*.sh,*bat exe "1," . "$" . "g/^#\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\t  \\/ ".strftime("%b %d, %Y")
"autocmd bufnewfile,Bufwritepre *.sas    exe "1," . "$" . "g/^*\\+\\s\\+QC.*/s/QC.*/QC\'r\\/Date:\t  \\/ ".strftime("%b %d, %Y")

"autocmd bufwritepost,filewritepost *.R,*.sh exe,*bat "!sed -f sed.txt -i ".expand("%")<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For headers in batch files
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd bufnewfile,Bufwritepre *.bat exe "1," . "10" . "g/Program:.*/s/Program:.*/Program:\t".expand("%")
autocmd bufnewfile,Bufwritepre *.bat exe "1," . "$" . "g/^set file=.*/s/file=.*/file=".expand("%")
autocmd bufnewfile,Bufwritepre *.bat exe "1," . "$" . "g/^set file=.*/s/bat$/R"
autocmd bufnewfile,Bufwritepre *.bat exe "1," . "$" . "g/^:\\+\\s\\+Programmer.*/s/Programmer.*/Programmer\\/Date:\tShuaicheng (Freeman) Wang \\/ ".strftime("%b %d, %Y")
autocmd bufnewfile,Bufwritepre *.bat exe "1," . "$" . "g/^:\\+\\s\\+Peer.*/s/Peer.*/Peer Reviewer\\/Date:\tFang Chen \\/ ".strftime("%b %d, %Y")
autocmd bufnewfile,Bufwritepre *.bat    exe "1," . "$" . "g/^:\\+\\s\\+QC.*/s/QC.*/QC\'r\\/Date:\tFang Chen \\/ ".strftime("%b %d, %Y")
autocmd bufwritepost,filewritepost *.R,*.sh,*.bat,*.sas execute "normal `b"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" copy and paste
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap yi "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa

" enable backspace
set backspace=2
set backspace=indent,eol,start
so ~/vimfiles/word_complete.vim
" :call DoWordComplete() 


vmap cc :s#^#/* #gv:s#$# */#

" align
nmap al :Align<- <CR>
vmap al :Align= <CR>
nmap fmt :exe "g/[^ ]<-[^ ]/s/<-/ <- /"<CR>

" set spell
nmap ss :set spell<CR>
nmap sns :set nospell<CR>


" Pandoc and Notes {{{1
command! -nargs=1 Ngrep vimgrep "<args>" $NOTES_DIR/**/*.txt
nnoremap <leader>[ :Ngrep 

command! -range=% Rst :'<,'>!pandoc -f markdown -t rst
nnoremap 'mh :w!<cr>:exe "!pandoc --latex-engine=lualatex -H ~/.cabal/fonts.tex -o " . fnameescape(expand('%:p:r')) . ".pdf " . fnameescape(expand('%:p'))<cr>
nnoremap 'md :w!<cr>:exe "!pandoc --latex-engine=lualatex -H ~/.cabal/fonts.tex -o $HOME/" . fnameescape(expand('%:t:r')) . ".pdf " .  fnameescape(expand('%:p'))<cr>
nnoremap 'mp :w!<cr>:exe "!pandoc --latex-engine=lualatex -H ~/.cabal/fonts.tex -o /tmp/" . fnameescape(expand('%:t:r')) . ".pdf " .  fnameescape(expand('%:p')) . " && xdg-open /tmp/" .  fnameescape(expand('%:t:r')) . ".pdf"<cr>


" Source
vnoremap <leader>S y:@"<CR>
nnoremap <leader>S ^vg_y:execute @@<cr>:echo 'Sourced line.'<cr>

" Clean trailing whitespace
nnoremap <leader>ww mz:%s/\s\+$//<cr>:let @/=''<cr>`z

" substitute
nnoremap <leader>s :%s///g<left><left>

" }}}
" Fugitive {{{

let g:fugitive_github_domains = ['github.banksimple.com']

nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>

augroup ft_fugitive
    au!

    au BufNewFile,BufRead .git/index setlocal nolist
augroup END

" "Hub"
vnoremap <leader>H :Gbrowse<cr>
nnoremap <leader>H V:Gbrowse<cr>

" "(Upstream) Hub"
vnoremap <leader>u :Gbrowse @upstream<cr>
nnoremap <leader>u V:Gbrowse @upstream<cr>

" }}}
"
" NERD Tree {{{
" noremap  <F2> :NERDTreeToggle<cr>
" inoremap <F2> <esc>:NERDTreeToggle<cr>


" quick larger and smaller font
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

" compile Rmd 
autocmd bufwritepre  *Rmd exe "!start /min Rscript.exe C:\\Users\\swa\\Documents\\compile_rmd.R " . '%:p' 
autocmd bufwritepost *Rmd exe '!start /min open.exe %:p:h' . '%:r.html'
autocmd bufwritepre  *md exe  '!start /min pandoc.exe ' . '%:p -o ' . '%:p.html' 
autocmd bufwritepost *md exe '!start /min open.exe %:p.html'

". ' -o ' . '%:p.docx'

" !Rscript.exe -e ' args <- commandArgs(TRUE); ifile=args[1]; library(rmarkdown); render(ifile)' . '%:p'


" function to quickly save notes
function! SaveNote(fn)
    "let l:fname = expand('%:p') . '__' . strftime('%Y_%m_%d')
    let l:fname = expand($HOME) . '/', expand(a:fn) . '__' . strftime('%Y_%m_%d')
    silent execute 'write' l:fname
    echomsg 'Wrote' l:fname
endfunction
nnoremap <Leader>sn :<C-U>call SaveNote("Leidos")<CR>
 

" install plugin using pathegen
execute pathogen#infect()

"cd ~/vimfiles/bundle
"git clone https://github.com/bling/vim-airline
"git clone https://github.com/tpope/vim-surround
"git clone https://github.com/scrooloose/nerdtree



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" from git
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu
set cmdheight=2
set display=uhex
set completeopt=menu
set noexpandtab
set history=1000
"set list listchars=trail:-,extends:>,precedes:<
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set laststatus=2
set ffs=unix "set ffs=dos




"I really hate that things don't auto-center
nmap G Gzz
nmap n nzz
nmap N Nzz
nmap } }zz
nmap { {zz

" delete surrounding characters
" noremap ss{ F{xf}x
noremap cs{ F{xf}xi
" noremap ss" F"x,x
noremap cs" F"x,xi
" noremap ss' F'x,x
noremap cs' F'x,xi
" noremap ss( F(xf)x
noremap cs( F(xf)xi
" noremap ss) F(xf)x
noremap cs) F(xf)xi

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




" R vim indent dplyr
"let r_indent_op_pattern = '%[^%]*%$'
let r_indent_op_pattern = '(+\|-\|\*\|/\|=\|\~\|%\)$'
let vimrplugin_assign = 0
" set fold in R
let r_syntax_folding = 1

" development code of Vim-R-plugin. You may want to adjust Vim's runtimepath in your ~/.vimrc as in the example below:
"set runtimepath=~/.vim/Vim-R-plugin,~/.vim,$VIMRUNTIME
"set runtimepath=~/.vim/Vim-R-plugin-47e1037013fe347b738f69a465a308b97123aa0d/,~/.vim,$VIMRUNTIME

":noremap <F4> :vertical wincmd gf<CR>

" similar to gf combination
nnoremap <silent> <leader>f :vertical botright wincmd f<CR>

"----------------------------------------------------------------------------
"update the hi settings
" somehow it was overwrited somewhere above
"----------------------------------------------------------------------------
"highlight LineNr ctermfg=14
"highlight Pmenu    ctermfg=20  ctermbg=22  guifg=20    guibg=#005f00
"highlight PmenuSel ctermfg=13  ctermbg=7   guifg=13    guibg=24
"highlight PmenuSbar    ctermbg=244      guibg=#808080



"----------------------------------------------------------------------------
" settings in 2017
"----------------------------------------------------------------------------
let g:NERDTreeWinPos = "right"

" NERDTree
nmap <leader>ne :NERDTree<cr>
noremap ; :

