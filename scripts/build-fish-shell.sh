#!/usr/bin/env bash
set -euo pipefail
set -x

# Fish shell version
FISH_VERSION=3.3.1

# Create temp. directory
tmp_dir=/tmp/fish_tmp_build
if [[ -d $tmp_dir ]]
then
    rm -r $tmp_dir
fi

mkdir $tmp_dir
cd $tmp_dir

# Download shell specified by fish version
wget https://github.com/fish-shell/fish-shell/releases/download/$FISH_VERSION/fish-$FISH_VERSION.tar.xz

tar xvf fish-$FISH_VERSION.tar.xz
cd fish-$FISH_VERSION
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=$HOME/.local
make install
