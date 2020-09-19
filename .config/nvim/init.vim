set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" init colorizer.lua
lua require'colorizer'.setup()

