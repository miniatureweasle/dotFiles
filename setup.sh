#!/bin/bash

txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldcyn='\e[1;36m' # Cyan
undpur='\e[4;35m' # Purple
txtrst='\e[0m'    # Text Reset

echo -e $bldcyn"Cleaning up workspace..."$txtrst

touch $HOME/.linuxsetup.log
LOG=$HOME"/.linuxsetup.log"

echo "" > $LOG

tar -cvzf backup.tar.gz .vim* spf* .dotFiles .bashrc .bash_* >> $LOG

rm -rf .vim* >> $LOG
rm -rf spf* >> $LOG
rm -rf .dotFiles >> $LOG

echo -e "["$txtgrn"done]"$txtrst

echo -e $bldcyn"Setting up linux environment..."$txtrst

# Setup and update linux repositories
echo -e "1. "$undpur"Updating and setting up repositories..."$txtrst
sudo apt-get update
echo -e "["$txtgrn"done]"$txtrst

# Get pip
echo -e "2. "$undpur"Getting Pip..."$txtrst
sudo easy_install pip >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get virtualenv
echo -e "3. "$undpur"Installing virtualenv for python"$txtrst
sudo pip install virtualenv >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get virtualenv wrapper
echo -e "4. "$undpur"Installing virtualenvwrapper for python"$txtrst
sudo pip install virtualenvwrapper >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Setup virtualenv wrapper
echo -e "5. "$undpur"Setting up virtualenv wrapper pyhton for bash"$txtrst
echo "source /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get i3
echo -e "6. "$undpur"Installing i3 window manager..."$txtrst
sudo apt-get install i3 dmenu -y >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get tmux
echo -e "7. "$undpur"Installing tmux..."$txtrst
sudo apt-get install tmux -y >> LOG
echo -e "["$txtgrn"done]"$txtrst

# Get vim
echo -e "8. "$undpur"Installing vim..."$txtrst
sudo apt-get install vim -y >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get git & subversion
echo -e "9. "$undpur"Installing git and subversion..."$txtrst
sudo apt-get install git subversion -y >> $LOG
echo -e "["$txtgrn"done]"$txtrst

# Get configs
echo -e "10. "$undpur"Pulling configs..."$txtrst
git clone http://github.com/upendra243/dotFiles.git >> $LOG
mv dotFiles .dotFiles
CONFIG_DIR=$HOME/.dotFiles
echo -e "["$txtgrn"done]"$txtrst

# Setup i3
echo -e "11. "$undpur"Setting up i3..."$txtrst
cp -r $CONFIG_DIR/.i3 ~/
echo -e "["$txtgrn"done]"$txtrst

# Setup conky status bar
echo -e "11.1 "$undpur"Setting up conky..."$txtrst
sudo apt-get install conky
cp $CONFIG_DIR/.conkyrc ~/

echo -e "["$txtgrn"done]"$txtrst
# Setup tmux
echo -e "12. "$undpur"Setting up tmux..."$txtrst
cp $CONFIG_DIR/.tmux.conf ~/
echo -e "["$txtgrn"done]"$txtrst

# Setup vim
echo -e "13. "$undpur"Setting up vim..."$txtrst
echo -e $txtcyn"Note: "$txtylw"This might take some time..."$txtrst
curl http://j.mp/spf13-vim3 -L -o - | sh
echo -e "["$txtgrn"done]"$txtrst

echo -e "14. "$undpur"Setting up vim..."$txtrst
cp $CONFIG_DIR/.vimrc.local ~/
echo -e "["$txtgrn"done]"$txtrst

echo -e $txtcyn"Checking..."$txtrst
echo -e "["$txtgrn"All Done]"$txtrst

exit

