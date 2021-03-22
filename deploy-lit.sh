# install plug.vim
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "plug.vim dose not exists. Now downloading to ~/.vim/autoload/plug.vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# clone and map rc files
if [ ! -d ~/github/dotfile_freestatman ]; then
    echo "freestatman dot repo dose not exists. Now downloading to ~/github/dotfile_freestatman"
    git clone https://github.com/freestatman/dotfile_freestatman ~/github/dotfile_freestatman
fi

# goto working dir
cd ~/github/dotfile_freestatman
git pull

mkdir -p ~/.config/fish/
mkdir -p ~/.config/nvim/
mkdir -p ~/.vim/plugged/vim-snippets/snippets/
mkdir -p ~/.vim/undodir/

ln -fs $PWD/.aliases ~/
ln -fs $PWD/.bashrc ~/
ln -fs $PWD/.config/fish/config.fish ~/.config/fish/config.fish
ln -fs $PWD/.config/nvim/init.vim ~/.config/nvim/init.vim
ln -fs $PWD/.git-completion.bash ~/
ln -fs $PWD/.git-prompt.bash ~/
ln -fs $PWD/.tmux.conf ~/
ln -fs $PWD/.screenrc ~/
ln -fs $PWD/.vim/snippets/r.snippets ~/.vim/plugged/vim-snippets/snippets/
ln -fs $PWD/.vimrc ~/
ln -fs $PWD/.vimrc.more ~/
ln -fs $PWD/.lintr ~/
ln -fs $PWD/rstudio-prefs.json ~/


# git config
git config --global user.email "shuaichengwang@gmail.com"
git config --global user.name "Freeman Wang"
git config --global diff.tool "vimdiff3"


