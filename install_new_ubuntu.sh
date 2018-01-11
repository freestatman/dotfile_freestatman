
sudo apt-get update
sudo apt-get install -y openssh-server
sudo service ssh status    
sudo service ssh start
sudo apt-get install -y pandoc
sudo apt-get install -y vim
sudo apt-get install -y vim-gnome # for +xterm_clipboard
sudo apt-get install -y tmux
sudo apt-get install -y git
sudo apt-get install -y python
sudo apt-get install -y python3-pip

sudo apt-get install -y r-base
sudo su - -c "R -e \"install.packages(c('shiny', 'ticyverse'), repos='https://cran.rstudio.com/')\""

# Shiny/Rstudio servers
sudo apt-get install -y gdebi-core
wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
sudo gdebi shiny-server-1.5.6.875-amd64.deb
wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
sudo gdebi rstudio-server-1.1.383-amd64.deb
sudo rstudio-server verify-installation
sudo rstudio-server start

sudo apt-get install -y default-jre
java -version

# install docker
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get install -y docker-ce



# for install neovim in unbuntu
sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install -y neovim
mkdir -p ~/.config/nvim/
echo "
set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim
source ~/.vimrc
" > ~/.config/nvim/init.vim
# config neovim

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

