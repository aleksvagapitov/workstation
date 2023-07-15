curl -sSL https://install.python-poetry.org | python3 -

# dotnet install
wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
chmod +x ./dotnet-install.sh
./dotnet-install.sh --channel 7.0
dotnet tool install --global csharp-ls

# install mono
apt install -y dirmngr gnupg apt-transport-https ca-certificates software-properties-common
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
apt-add-repository -y 'deb https://download.mono-project.com/repo/ubuntu stable-focal main'
apt update
apt install -y mono-complete

# omnisharp install
# curl --verbose --location --remote-name https://github.com/OmniSharp/omnisharp-roslyn/releases/download/v1.37.5/omnisharp-linux-x64.tar.gz
# mkdir -p .local/omnisharp
# mv omnisharp-linux-x64.tar.gz .local/omnisharp
# cd .local/omnisharp
# tar -xvf omnisharp-linux-x64.tar.gz

# Neovim plugins
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
  /home/user/.local/share/nvim/site/pack/packer/start/packer.nvim

git clone --depth=1 https://github.com/savq/paq-nvim.git \
    /home/user/.local/share/nvim/site/pack/paqs/start/paq-nvim

sudo chown -R user /home/user/.local/share

# Oh-my-zsh install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

# Move config files
shopt -s dotglob
mv -v /home/user/tmp/* /home/user/

# Git config
git config --global user.email "aleksvagapitov@gmail.com"
git config --global user.name "Aleksandr Agapitov"


chsh -s $(which zsh)
