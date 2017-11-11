
# install pandoc
sudo apt-get update
sudo apt-get install pandoc
sudo apt-get install vim
sudo apt-get install vim-gnome # for +xterm_clipboard
sudo apt-get install tmux
sudo apt-get install git
sudo apt-get install python
sudo apt-get install python3-pip

# for install neovim in unbuntu
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
mkdir -p ~/.config/nvim/
echo "
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
" > ~/.config/nvim/init.vim

# config neovim


# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce


# install vim Vundle, then you need to :BundleInstall
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

mkdir -p ~/github/
cd ~/github/

git clone https://github.com/wangtulao/dotfile_swa

cd dotfile_swa
ln -f .vimrc ~/
ln -f .bashrc ~/
ln -f .tmux.conf ~/


# install i3 window manager
# after the installation, log out and log back in
sudo apt update
sudo apt install i3
sudo apt-get install arandr # GUI for setting moniter resolution

