#!/bin/bash

app_dir="$HOME/.dotfiles"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

unlink $HOME/.bash_profile > /dev/null 2>&1
unlink $HOME/.bashrc > /dev/null 2>&1
unlink $HOME/.profile > /dev/null 2>&1
unlink $HOME/.shellactivities > /dev/null 2>&1
unlink $HOME/.shellaliases > /dev/null 2>&1
unlink $HOME/.shellpaths > /dev/null 2>&1
unlink $HOME/.shellvars > /dev/null 2>&1
unlink $HOME/.shellcolors > /dev/null 2>&1
unlink $HOME/.zlogout > /dev/null 2>&1
unlink $HOME/.zprofile > /dev/null 2>&1
unlink $HOME/.zshenv > /dev/null 2>&1
unlink $HOME/.zshrc > /dev/null 2>&1

unlink $HOME/.vimrc.bundles > /dev/null 2>&1
unlink $HOME/.vimrc.before > /dev/null 2>&1

unlink $HOME/.gemrc > /dev/null 2>&1
unlink $HOME/.rvmc > /dev/null 2>&1
unlink $HOME/.netrc > /dev/null 2>&1
unlink $HOME/.gitconfig > /dev/null 2>&1
unlink $HOME/.slate > /dev/null 2>&1

rm $HOME/.vimrc > /dev/null 2>&1
rm $HOME/.vim > /dev/null 2>&1
rm $HOME/.vimrc.local > /dev/null 2>&1

rm -rf $app_dir > /dev/null 2>&1
rm -rf ~/.vimbackup > /dev/null 2>&1
rm -rf ~/.vimswap > /dev/null 2>&1
rm -rf ~/.vimundo > /dev/null 2>&1
rm -rf ~/.vimviews > /dev/null 2>&1
