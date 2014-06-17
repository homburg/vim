" Problems with fish shell (Syntastic)
set shell=/bin/bash

let mapleader=","
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2011 Apr 15
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set ts=4
set sw=4

set number

let mapleader = ","

" Noter til vim-pipe
"
" autorun python
"
" :let b:vimpipe_command="python"
" :au BufWritePost *.py call VimPipe()
"
" execute self
" :let b:vimpipe_command="./%"

" Smarty
au BufRead,BufNewFile *.tpl set filetype=smarty

let g:Grep_Default_Options = '-I --exclude-dir=.svn'
let g:Grep_Skip_Dirs = '.svn'

set dir=~/tmp/vimswaps
set bdir=~/tmp/vimswaps

set tags=./tags,./TAGS,tags,TAGS,~/.vim/tags

" vimux run last command on \r
" unmap \r " No such mapping
nnoremap <LocalLeader>r :VimuxRunLastCommand<cr>

" golint
function! s:GoLint()
	cexpr system("golint " . shellescape(expand('%')))
	copen
endfunction
command! GoLint :call s:GoLint()

" Enable autocompletion on startup
let g:acp_enableAtStartup = 1

function! AcpMeetsForGo(context)
	  return &omnifunc != '' && a:context =~ '\k\.\k*$'
  endfunction

let g:acp_behavior = {
	\  'go': [{
	\	'command': "\<C-x>\<C-o>",
	\	'meets': 'AcpMeetsForGo',
	\	'repeat': 0
	\  }]
	\ }

" ctrlp.vim settings
" " Use actual working dir, if parent dir of opened file
let g:ctrlp_working_path_mode = 'a'

"" NERDTree
map <C-e> :NERDTreeToggle<CR>

" Close NERDTree on last window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Syntastic: php
let g:syntastic_php_phpcs_args="--standard=PSR2 --report=csv"
" Auto open loc list for errors
let g:syntastic_auto_loc_list=1

" Vundle
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Bundle 'gmarik/Vundle.vim'

" Languages
" scala
Bundle 'derekwyatt/vim-scala'
" coffee-script
Bundle 'kchmck/vim-coffee-script'
" jade
Bundle 'digitaltoad/vim-jade'
" golang
" Bundle 'jnwhiteh/vim-golang'
Bundle 'Blackrush/vim-gocode'
" stylus
Bundle 'wavded/vim-stylus'
" LiveScript
Bundle 'gkz/vim-ls'
" clojure
Bundle 'tpope/vim-fireplace'
Bundle 'tpope/vim-classpath'
Bundle 'guns/vim-clojure-static'
Bundle 'kien/rainbow_parentheses.vim'
Bundle 'guns/vim-sexp'
" yaml (ansible)
Bundle 'chase/vim-ansible-yaml'
Bundle 'stephpy/vim-yaml'


" Themes
" Bundle 'jellybeans.vim'
Bundle 'w0ng/vim-hybrid'

" VCS
Bundle 'tpope/vim-fugitive'
Bundle 'vcscommand.vim'

" Other
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-ragtag'
Bundle 'tpope/vim-commentary'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'junegunn/goyo.vim'
Bundle 'amix/vim-zenroom2'
Bundle 'editorconfig/editorconfig-vim'
Bundle 'mattn/emmet-vim'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tpope/vim-unimpaired'

call vundle#end()
filetype plugin indent on

colorscheme hybrid

" Rainbow parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

