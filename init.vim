"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / | | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
"   \_/ |_|_| |_| |_|_|  \___|
"

set nocompatible

" XDG Compatibility Stuff
" -----------------------

" Assign the defaults when the environment doesn't provide them.
if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = $HOME.'/.cache'
endif
if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = $HOME.'/.config'
endif

" Make sure any configuration directories/paths exist.
if !isdirectory($XDG_CACHE_HOME."/vim/swap")
  call mkdir($XDG_CACHE_HOME."/vim/swap", "p")
endif
if !isdirectory($XDG_CACHE_HOME."/vim/backup")
  call mkdir($XDG_CACHE_HOME."/vim/backup", "p")
endif
if !isdirectory($XDG_CACHE_HOME."/vim/undo")
  call mkdir($XDG_CACHE_HOME."/vim/undo", "p")
endif
if !isdirectory($XDG_CACHE_HOME."/vim/view")
  call mkdir($XDG_CACHE_HOME."/vim/view", "p")
endif

let &undodir=$XDG_CACHE_HOME.'/vim/undo'
let &directory=$XDG_CACHE_HOME.'/vim/swap'
let &backupdir=$XDG_CACHE_HOME.'/vim/backup'
let &viewdir=$XDG_CACHE_HOME.'/vim/view'
let &runtimepath=expand('$XDG_CONFIG_HOME/vim,$VIMRUNTIME,$XDG_CONFIG_HOME/vim/after')
let g:netrw_home=$XDG_CACHE_HOME.'/vim'

source $XDG_CONFIG_HOME/vim/plugins.vim                                        " Load vim plugin configuration
source $XDG_CONFIG_HOME/vim/statusline.vim                                     " Load custom statusline theme

let mapleader = " "
let maplocalleader = " "

" Load mods (keymaps, opts, utils, autocmds, etc)
for mod in split(globpath('$XDG_CONFIG_HOME/vim/mods'), '\n')
	execute 'source' mod
endfor

" Bootstrap vim-plug in correct XDG_CONFIG_HOME location
let data_dir = $XDG_DATA_HOME.'/vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

if filereadable($XDG_CONFIG_HOME.'/vim/autoload/plug.vim')
	call plug#begin()
		for plug_conf in split(globpath('~/.vim/plugs/*.vim'), '\n')
			execute 'source' plug_conf
		endfor
	call plug#end()
endif

execute 'PlugInstall --sync | source $MYVIMRC'
