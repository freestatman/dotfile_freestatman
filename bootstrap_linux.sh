
sudo apt-get update
sudo apt-get install -y openssh-server
sudo service ssh status
sudo service ssh start
sudo apt-get install -y pandoc
sudo apt-get install -y vim
sudo apt-get install -y tmux
sudo apt-get install -y git
sudo apt-get install -y fish
sudo apt-get install -y zsh
sudo apt-get install -y curl

#--------------------------------------------------------
# Python, pip, and aws cli
#--------------------------------------------------------
sudo apt-get install -y python-pip
sudo apt-get install -y python3-pip
sudo apt-get install -y awscli
pip3 install awscli --upgrade --user
aws --version

## powerline installation
pip install powerline-status
sudo apt-get install fonts-powerline
source /home/pi/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh
PATH=$PATH:~/.local/bin

#aws configure
#aws s3 ls

#--------------------------------------------------------
# R and packages
#--------------------------------------------------------
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
sudo apt update
sudo apt install -y r-base

# R/tidyverse dependency
sudo apt install -y libxml2-dev
sudo apt install -y libcurl4-openssl-dev libssl-dev

sudo Rscript install.R


#--------------------------------------------------------
# Shiny/Rstudio servers
#--------------------------------------------------------

sudo apt-get install gdebi-core
wget https://download2.rstudio.org/server/trusty/amd64/rstudio-server-1.2.5042-amd64.deb
sudo gdebi rstudio-server-1.2.5042-amd64.deb

wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.9.923-amd64.deb
sudo gdebi shiny-server-1.5.9.923-amd64.deb

sudo rstudio-server verify-installation
sudo rstudio-server start

#sudo apt-get install -y gdebi-core
#wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb
#sudo gdebi shiny-server-1.5.6.875-amd64.deb
#wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
#sudo gdebi rstudio-server-1.1.383-amd64.deb

sudo apt-get install -y default-jre
java -version

#--------------------------------------------------------
# install docker
#--------------------------------------------------------
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

#----------------------------------------------------------------------------
# add docker user group
#----------------------------------------------------------------------------
sudo groupadd docker
sudo usermod -aG docker $USER

docker ps


#-----------------------------------------------------------
# virtualbox utils
#-----------------------------------------------------------
sudo apt-get install virtualbox-guest-utils
sudo apt install cifs-utils
mkdir -p ~/share
sudo mount -t vboxsf www ~/share

#-----------------------------------------------------------
# for install neovim in unbuntu
# sudo apt-get install -y software-properties-common
# sudo add-apt-repository ppa:neovim-ppa/stable
# sudo apt-get update
# sudo apt-get install -y neovim
# mkdir -p ~/.config/nvim/
# echo "
# set runtimepath+=~/.vim,~/.vim/after
# set packpath+=~/.vim
# source ~/.vimrc
# " > ~/.config/nvim/init.vim
# # config neovim

#-----------------------------------------------------------
# vim and dotfiles
#-----------------------------------------------------------
# install vim Vundle, then you need to :BundleInstall
# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# switch from Vundle to Plug
# download & install plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/github/
cd ~/github/

git clone https://github.com/freestatman/dotfile_swa

cd ~/github/dotfile_swa
ln -fs $PWD/.vimrc ~/
ln -fs $PWD/.bashrc ~/
ln -fs $PWD/.tmux.conf ~/
ln -fs $PWD/.aliases ~/
mkdir -p ~/.config/fish/
ln -f $PWD/.config/fish/config.fish ~/.config/fish/config.fish
ln -fs $PWD/.vim/snippets/r.snippets ~/.vim/plugged/vim-snippets/snippets/
ln -fs $PWD/.git-completion.bash ~/
ln -fs $PWD/.git-prompt.bash ~/


# install i3 window manager
# after the installation, log out and log back in
#sudo apt update
#sudo apt install i3 #sudo apt-get install arandr # GUI for setting moniter resolution

git config --global user.email "shuaichengwang@gmail.com"
git config --global user.name "Freeman Wang"
git config --global diff.tool "vimdiff3"

