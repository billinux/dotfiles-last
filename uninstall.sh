#!/bin/bash

app_dir="$HOME/.dotfiles"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

unlink $HOME/.bash_profile
unlink $HOME/.bashrc
unlink $HOME/.profile
unlink $HOME/.shellactivities
unlink $HOME/.shellaliases
unlink $HOME/.shellpaths
unlink $HOME/.shellvars
unlink $HOME/.shellcolors
unlink $HOME/.zlogout
unlink $HOME/.zprofile
unlink $HOME/.zshenv
unlink $HOME/.zshrc

unlink $HOME/.vimrc.bundles
unlink $HOME/.vimrc.before


unlink $HOME/.gemrc
unlink $HOME/.rvmc
unlink $HOME/.netrc
unlink $HOME/.gitconfig
unlink $HOME/.slate

rm $HOME/.vimrc
rm $HOME/.vim

rm -rf $app_dir
