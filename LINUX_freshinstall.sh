sudo apt install git llvm gcc build-essentials zsh stow neovim tmux nodejs bat npm
mkdir Softwares
cd Softwares/
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Linux-x86_64.sh
chmod +x Miniconda3-py39_4.10.3-Linux-x86_64.sh 
./Miniconda3-py39_4.10.3-Linux-x86_64.sh 
cd ~/
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
cd dotfiles/
stow git
stow tmux
stow LINUX_zsh
stow vim
stow ssh
cd misc
cp .clang-format ~/
cd ~/
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
mkdir ~/.vim/.undo
mkdir ~/.vim/.backup
mkdir ~/.vim/.swp
