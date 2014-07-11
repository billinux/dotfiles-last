# Vim Modular

[![Vim modular][1]][2]
[1]: http://www.vim.org/images/vim_editor.gif
[2]: http://www.vim.org/ "Click to visit vim.org"

This vim repository is modular.that's mean :

| Folder   | Store                                                                |
| ------   | -------------------------------------------------------------------- |
| bundles  | all common vim bundles                                               |
| bundle   | symlinked bundle (ex: ln -s ../bundles/vim-fugitive)                 |
| config   | config files (not a giant vimrc)                                     |
| ftbundle | all filetype bundles (ex: sh, php, ruby, python, markdown, ect..)    |

I use [vim-unbundle](https://github.com/sunaku/vim-unbundle) to manage bundles
or [vim-pathogen](https://github.com/tpope/vim-pathogen) to manage bundles and ftbundles.

## Prerequisites

* [Vim](http://www.vim.org/) 7.3 or newer

* [Git](http://git-scm.com/) 1.5 or newer

* [POSIX shell](http://pubs.opengroup.org/onlinepubs/009695399/utilities/sh.html

[Unbundle]: https://github.com/sunaku/vim-unbundle

## Installing

Backup your configuration:

    mv ~/.vim ~/.vim.bak
    mv ~/.vimrc ~/.vimrc.bak

Install this configuration:

    git clone git://github.com/billinux/.vimod.git ~/.vim
    ln -s ~/.vim/config.vim ~/.vimrc

Select a Git branch to use:

    cd ~/.vim
    git checkout master  # bare bones
    git checkout config  # bare bones + my config
    git checkout bundle  # bare bones + my config + my bundles

Install bundles from `*.get` files:

    cd ~/.vim
    sh bundle.sh

## Bundling

Add bundle from *URL*:

    cd ~/.vim
    sh addnew.sh URL

Add ftbundle for *FILETYPE* from *URL*:

    cd ~/.vim
    sh addnew.sh URL FILETYPE

Remove bundle called *NAME* (regexp):

    cd ~/.vim
    sh remove.sh NAME

Remove ftbundle for *FILETYPE* called *NAME* (regexp):

    cd ~/.vim
    sh remove.sh FILETYPE/NAME

List bundles and ftbundles that lack corresponding `*.get` files:

    cd ~/.vim
    sh zombie.sh

## Locking

Lock a *BUNDLE* to a certain Git *COMMIT* to prevent it from being upgraded:

    cd BUNDLE
    git checkout COMMIT

Unlock a locked *BUNDLE* so that it can be upgraded again:

    cd BUNDLE
    git checkout master

## Upgrading

Upgrade the configuration framework:

    cd ~/.vim
    sh rebase.sh

Upgrade bundles from `*.get` files:

    cd ~/.vim
    sh bundle.sh

Do all this periodically via crontab(1):

    @daily cd ~/.vim && sh rebase.sh && sh bundle.sh

## Author
[Bill Linux](mailto:bill.linux@laposte.net)


