
cd ~/github/dotfile_swa
mkdir -p ~/.config/fish/
mkdir -p ~/.vim/plugged/vim-snippets/snippets/

ln -f .vimrc ~/
ln -f .bashrc ~/
ln -f .git-prompt.bash ~/
ln -f .tmux.conf ~/
ln -f .config/fish/config.fish ~/.config/fish/config.fish
ln -f .vim/snippets/r.snippets ~/.vim/plugged/vim-snippets/snippets/
