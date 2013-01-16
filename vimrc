set nocompatible
set expandtab
set shiftwidth=2
set softtabstop=2
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive.git'
Bundle 'scrooloose/nerdtree.git'
Bundle 'tpope/vim-rvm.git'
Bundle 'tpope/vim-endwise.git'
Bundle 'tpope/vim-surround.git'
Bundle 'vim-scripts/AutoClose'
"Bundle 'vim-scripts/slimv.vim'
Bundle 'kchmck/vim-coffee-script'
"Bundle 'tpope/vim-haml'
Bundle 'altercation/vim-colors-solarized'
Bundle 'wincent/Command-T'
Bundle 'benmills/vimux'
Bundle 'mattn/zencoding-vim'

filetype on
filetype indent on
filetype plugin on

imap jk <Esc>
" Change mapleader from \ to ,
let mapleader=","
syntax on
set tags+=gems.tags

set background=dark
colorscheme solarized

" Vivo_Admin
" When in a resource, open its map
map <Leader>mp :e lib/duke_vivo_mapper/maps/%:t:r_map.rb<CR>
" When in a map, open its resource
map <Leader>rs :e lib/duke_vivo_mapper/resources/%:t:r:s/_map//.rb<CR>

function! SwitchToMap(currentpath)
  let filename=a:currentpath
endfunction

map ,jc :!javac % <CR>
map ,t :CommandT <CR>

" Switch to last window
map ,, <C-^>

"Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

"Vimux
" If text is selected, save it in v buffer and send to tmux
vmap <Leader>vt "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vt vip<Leader>vt<CR>

let g:VimuxOrientation = "h"
let g:VimuxHeight = "25"
let VimuxUseNearestPane = 1

" Run the current file with rspec
map <Leader>vs :call VimuxRunCommand("clear; rspec " . bufname("%"))<CR>
" Run the current spec with rspec
map <Leader>vo :call VimuxRunCommand("clear; rspec " . expand("%p") . ":" . line("."))<CR>
" Run all specs
map <Leader>va :call VimuxRunCommand("clear; rspec spec")<CR>
" Run all model specs
map <Leader>vm :call VimuxRunCommand("clear; rspec spec/models")<CR>
" Run all controller specs
map <Leader>vc :call VimuxRunCommand("clear; rspec spec/models")<CR>
" Prompt for a command to run map
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane 
map <Leader>vi :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane map
map <Leader>vx :VimuxInterruptRunner<CR>

"Run the current file with minitest
map <Leader>ms :call VimuxRunCommand("clear; ruby -rminitest/pride " . bufname("%"))<CR>
"Run all specs with minitest
map <Leader>ma :call VimuxRunCommand("clear; ruby -rminitest/pride spec/specs.rb")<CR>

"IRB
"Load the current file in ruby
map <Leader>lf :call VimuxRunCommand("load \'" . bufname("%") . "\'")<CR>

"Surround shortcuts
"Surround all text on line
map <Leader>ss $v^S

set backupdir=$HOME/.vim_backups
set directory=$HOME/.vim_backups

" Paste toggle
set pastetoggle=<F2>

" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")


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
  augroup END

else

  set expandtab		" pressing <TAB> will insert 'softtabstop' # of spaces
  set shiftwidth=2	" amount of indentation auto used for each level
  set softtabstop=2

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"EVERYTHING below here is from http://biodegradablegeek.com/2007/12/using-vim-as-a-complete-ruby-on-rails-ide/

" Add recently accessed projects menu (project plugin)
set viminfo^=!

" Minibuffer Explorer Settings
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" alt+n or alt+p to navigate between entries in QuickFix
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

let g:slimv_swank_cmd = '! xterm -e scheme --load /home/patrick/.vim/bundle/slimv.vim/slime/contrib/swank-mit-scheme.scm &'
