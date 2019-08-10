# Use stow to symlink all configurations to $HOME
current_path=`pwd`
dotdir=`dirname $0`
cd $dotdir/configs
stow * -t $HOME -v
cd $current_path
