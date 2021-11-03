brew update
brew install nvm
mkdir ~/.nvm
echo '
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
' >> ~/.zshrc
. ~/.zshrc
nvm install 14
nvm ls
nvm use 14