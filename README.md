# Dotfiles

[![Dotfiles][1]][2]
[1]: http://www.vim.org/images/vim_editor.gif
[2]: http://www.vim.org/ "Click to visit vim.org"



## Prerequisites

* [Vim](http://www.vim.org/) 7.3 or newer
* [Git](http://git-scm.com/) 1.7 or newer
* [Curl](http://http://curl.haxx.se/) 7.37 or newer
* [POSIX shell](http://pubs.opengroup.org/onlinepubs/009695399/utilities/sh.html)


## Installation
Using Curl to install the latest dotfiles
```bash
    curl http://j.mp/billinux -L -o - | sh
```

Using Wget to install the latest dotfiles
```bash
    wget http://j.mp/billinux -L -o - | sh 
```

## Uninstallation
```bash
    curl http://j.mp/unbillinux -L -o | sh
```

## Updating to the latest version
```bash
    curl http://j.mp/billinux -L -o - | sh
```
### Auto update
```bash
    curl http://j.mp/billinux -L -o - | sh
```

### Manual update
    cd $HOME/.dotfiles
    git pull
    vim +BundleInstall! +BundleClean +q

## Customization
Create `~/.vimrc.local` and `~/.gvimrc.local` for any local customisation.
For example, to override the default coloscheme:

```bash
    echo colorscheme ir_black  >> ~/.vimrc.local
```

### Before File

Create a `~/.vimrc.before.local` file to define any customizations
that get loaded *before* the dotfiles `.vimrc`.

For example, to prevent autocd into a file directory:
```bash
    echo let g:Billinux_no_spell = 1 >> ~/.vimrc.before.local
```
For a list of available dotfiles specific customization options, look at the `~/.vimrc.before` file.

## Author
[Bill Linux](mailto:bill.linux@laposte.net)


