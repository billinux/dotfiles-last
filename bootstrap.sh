#!/bin/bash


############################  SETUP PARAMETERS
app_name='dotfiles'
app_dir="$HOME/.dotfiles"
[ -z "$git_uri" ] && git_uri='https://github.com/billinux/dotfiles.git'
git_branch='master'
debug_mode='0'
fork_maintainer='0'
[ -z "$VUNDLE_URI" ] && VUNDLE_URI="https://github.com/gmarik/vundle.git"
############################  BASIC SETUP TOOLS
msg() {
    printf '%b\n' "$1" >&2
}

success() {
    if [ "$ret" -eq '0' ]; then
    msg "\e[32m[✔]\e[0m ${1}${2}"
    fi
}

error() {
    msg "\e[31m[✘]\e[0m ${1}${2}"
    exit 1
}

debug() {
    if [ "$debug_mode" -eq '1' ] && [ "$ret" -gt '1' ]; then
      msg "An error occurred in function \"${FUNCNAME[$i+1]}\" on line ${BASH_LINENO[$i+1]}, we're sorry for that."
    fi
}

############################ SETUP FUNCTIONS
program_exists() {
    local ret='0'
    type $1 >/dev/null 2>&1 || { local ret='1'; }

    # throw error on non-zero return value
    if [ ! "$ret" -eq '0' ]; then
    error "$2"
    fi
}

lnif() {
    if [ -e "$1" ]; then
        ln -sf "$1" "$2"
    fi
    ret="$?"
    debug
}


do_backup() {
    if [ -e "$2" ] || [ -e "$3" ] || [ -e "$4" ] || [ -e "$5" ] || [ -e "$6" ]; then
        today=`date +%Y%m%d_%s`
        for i in "$2" "$3" "$4" "$5" "$6" ; do
            [ -e "$i" ] && [ ! -L "$i" ] && mv "$i" "$i.$today";
        done
        ret="$?"
        success "$1"
        debug
   fi
}

upgrade_repo() {
      msg "trying to update $1"

      if [ "$1" = "$app_name" ]; then
          cd "$app_dir" &&
          git pull origin "$git_branch"
      fi

      if [ "$1" = "vundle" ]; then
          cd "$HOME/.vim/bundle/vundle" &&
          git pull origin master
      fi

      ret="$?"
      success "$2"
      debug
}

clone_repo() {
    program_exists "git" "Sorry, we cannot continue without GIT, please install it first."

    if [ ! -e "$app_dir" ]; then
        git clone --recursive -b "$git_branch" "$git_uri" "$app_dir"
        ret="$?"
        success "$1"
        debug
    else
        upgrade_repo "$app_name"    "Successfully updated $app_name"
    fi
}

clone_vundle() {
    if [ ! -e "$HOME/.vim/bundle/vundle" ]; then
        git clone $VUNDLE_URI "$HOME/.vim/bundle/vundle"
    else
        upgrade_repo "vundle"   "Successfully updated vundle"
    fi
    ret="$?"
    success "$1"
    debug
}

create_symlinks() {
    endpath="$app_dir"

    if [ ! -d "$endpath/vim/bundle" ]; then
        mkdir -p "$endpath/vim/bundle"
    fi

    lnif "$endpath/bash_profile"        "$HOME/.bash_profile"
    lnif "$endpath/bashrc"              "$HOME/.bashrc"
    lnif "$endpath/profile"             "$HOME/.profile"
    lnif "$endpath/shellactivities"     "$HOME/.shellactivities"
    lnif "$endpath/shellaliases"        "$HOME/.shellaliases"
    lnif "$endpath/shellpaths"          "$HOME/.shellpaths"
    lnif "$endpath/shellvars"           "$HOME/.shellvars"
    lnif "$endpath/shellcolors"         "$HOME/.shellcolors"
    lnif "$endpath/zlogout"             "$HOME/.zlogout"
    lnif "$endpath/zprofile"            "$HOME/.zprofile"
    lnif "$endpath/zshenv"              "$HOME/.zshenv"
    lnif "$endpath/zshrc"               "$HOME/.zshrc"

    lnif "$endpath/vimrc"               "$HOME/.vimrc"
    lnif "$endpath/vimrc.bundles"       "$HOME/.vimrc.bundles"
    lnif "$endpath/vimrc.bundles.default"       "$HOME/.vimrc.bundles.default"
    lnif "$endpath/vimrc.before"        "$HOME/.vimrc.before"
    lnif "$endpath/vim"                 "$HOME/.vim"

    lnif "$endpath/gemrc"               "$HOME/.gemrc"
    lnif "$endpath/rvmc"                "$HOME/.rvmc"
    lnif "$endpath/netrc"               "$HOME/.netrc"
    lnif "$endpath/gitconfig"           "$HOME/.gitconfig"
    lnif "$endpath/slate"               "$HOME/.slate"

    # Useful for fork maintainers
    touch  "$HOME/.vimrc.local"

    if [ -e "$endpath/vimrc.fork" ]; then
        ln -sf "$endpath/vimrc.fork" "$HOME/.vimrc.fork"
    elif [ "$fork_maintainer" -eq '1' ]; then
        touch "$HOME/.vimrc.fork"
        touch "$HOME/.vimrc.bundles.fork"
        touch "$HOME/.vimrc.before.fork"
    fi

    if [ -e "$endpath/vimrc.bundles.fork" ]; then
        ln -sf "$endpath/vimrc.bundles.fork" "$HOME/.vimrc.bundles.fork"
    fi

    if [ -e "$endpath/vimrc.before.fork" ]; then
        ln -sf "$endpath/vimrc.before.fork" "$HOME/.vimrc.before.fork"
    fi

    ret="$?"
    success "$1"
    debug
}

setup_vundle() {
    system_shell="$SHELL"
    export SHELL='/bin/sh'

    vim \
        -u "$app_dir/vimrc.bundles" \
        "+set nomore" \
        "+BundleInstall!" \
        "+BundleClean" \
        "+qall"

    export SHELL="$system_shell"

    success "$1"
    debug
}

############################ MAIN()
program_exists "vim" "To install $app_name you first need to install Vim."

do_backup   "Your old vim stuff has a suffix now and looks like .vim.`date +%Y%m%d%S`" \
        "$HOME/.vim" \
        "$HOME/.vimrc" \
        "$HOME/.bashrc"\
        "$HOME/.bashrc_profile"\
        "$HOME/.profile"

clone_repo      "Successfully cloned $app_name"

create_symlinks "Setting up vim symlinks"

clone_vundle    "Successfully cloned vundle"

setup_vundle    "Now updating/installing plugins using Vundle"

msg             "\nThanks for installing $app_name."
