
# install pandoc
sudo apt-get update
sudo apt-get install pandoc
sudo apt-get install vim
sudo apt-get install tmux
sudo apt-get install git
sudo apt-get install python
sudo apt-get install python3-pip

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


