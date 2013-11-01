set nocompatible
set expandtab
set shiftwidth=2
set softtabstop=2
set relativenumber
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'tpope/vim-fugitive.git'
"Bundle 'scrooloose/nerdtree.git' # corrupting characters
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
Bundle 'scrooloose/nerdcommenter.git'
Bundle 'jwhitley/vim-matchit.git'
Bundle 'tpope/vim-fireplace'
Bundle 'guns/vim-clojure-static'
Bundle 'patrickmcelwee/ftl-vim-syntax'
Bundle 'groenewege/vim-less'
Bundle 'mattpap/vim-owl-tools'

filetype on
filetype indent on
filetype plugin on

imap jk <Esc>
" Change mapleader from \ to ,
" Remap comma function
let mapleader=" "
syntax on
set tags+=gems.tags

set background=dark
colorscheme solarized

" Vivo_Admin
" When in a resource, open its map
map <Leader>mp :e app/maps/%:t:r_map.rb<CR>
  " When in a map, open its resource
  map <Leader>rs :e lib/duke_vivo_mapper/resources/%:t:r:s/_map//.rb<CR>
  map <Leader>gdm :CommandTFlush<CR>\|:CommandT lib/duke_vivo_mapper/maps<CR>
  map <Leader>gdr :CommandTFlush<CR>\|:CommandT lib/duke_vivo_mapper/resources<CR>
  map <Leader>gds :CommandTFlush<CR>\|:CommandT lib/duke_vivo_mapper/sources<CR>
  map <Leader>gdd :CommandTFlush<CR>\|:CommandT lib/duke_vivo_mapper/models<CR>

  " Code to create a new data loader
  map <leader>d a<space>Rails.configuration.data_loader_factory.create_data_loader<Esc>
  map <leader>es aexpect(subject.)<Esc>==g_i

" Command T
map <Leader>f :CommandT <CR>
map <Leader>gv :CommandTFlush<CR>\|:CommandT app/views<cr>

map <Leader>jc :!javac % <CR>
map <Leader>nd :NERDTreeToggle<CR>

" Lazy save
map <Leader>w :w<CR>

" Switch to last window
map <Leader><Leader> <C-^>

"Open this rc file
map <Leader>rc :e ~/.vimrc<CR>

"Move between windows
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

"Create directory for current open file
map <Leader>md :!mkdir -p %:h<CR>

"Vimux
" If text is selected, save it in v buffer and send to tmux
vmap <Leader>vt "vy :call VimuxRunCommand(@v . "\n", 0)<CR>
" Select current paragraph and send it to tmux
nmap <Leader>vt vip<Leader>vt
nmap <Leader>vv V<Leader>vt

let g:VimuxOrientation = "h"
let g:VimuxHeight = "23"
let VimuxUseNearestPane = 1

" Run the current file with rspec, excluding js specs
map <Leader>vs :call VimuxRunCommand("rspec --tag ~js " . bufname("%"))<CR>
" Run the current spec with rspec, including js specs
map <Leader>vjs :call VimuxRunCommand("rspec " . bufname("%"))<CR>
" Run the current spec with rspec
map <Leader>vo :call VimuxRunCommand("rspec " . expand("%p") . ":" . line("."))<CR>
" Run all specs
map <Leader>va :call VimuxRunCommand("JRUBY_OPTS='$JRUBY_OPTS -J-XX:MaxPermSize=112m' rspec spec")<CR>
" Run all model specs
map <Leader>vm :call VimuxRunCommand("rspec spec/models")<CR>
" Run all controller specs
map <Leader>vc :call VimuxRunCommand("rspec spec/models")<CR>
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

"Run the current file with test_unit
map <Leader>ru :call VimuxRunCommand("ruby -Itest " . bufname("%"))<CR>
"Run the current spec with test_unit
map <Leader>ro :call VimuxRunCommand("clear; ruby " . expand("%p") . ":" . line("."))<CR>

"Run all tests
map <Leader>rt :call VimuxRunCommand("clear; bundle exec rake test")<CR>
"Run the current file with minitest
map <Leader>ms :call VimuxRunCommand("clear; ruby -Itest -rminitest/pride " . bufname("%"))<CR>
"Run all specs with minitest
map <Leader>ma :call VimuxRunCommand("clear; ruby -Itest -rminitest/pride spec/specs.rb")<CR>

"IRB
"Load the current file in ruby
"Make this harder to do
map <Leader>+lf :call VimuxRunCommand("load \'" . bufname("%") . "\'")<CR>

"Surround shortcuts
"Surround all text on line
map <Leader>ss $v^S
" Clear the search buffer
map <Leader>h :nohlsearch<cr>

" Directory of current file with '%%'
cnoremap %% <C-R>=expand('%:h').'/'<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>rn :call RenameFile()<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PROMOTE VARIABLE TO RSPEC LET
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! PromoteToLet()
  :normal! dd
  " :exec '?^\s*it\>'
  :normal! P
  :.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/
  :normal ==
endfunction
:command! PromoteToLet :call PromoteToLet()
:map <leader>p :PromoteToLet<cr>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" SWITCH BETWEEN TEST AND PRODUCTION CODE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! OpenTestAlternate()
  let new_file = AlternateForCurrentFile()
  exec ':e ' . new_file
endfunction
function! AlternateForCurrentFile()
  let current_file = expand("%")
  let new_file = current_file
  let in_spec = match(current_file, '^spec/') != -1
  let going_to_spec = !in_spec
  let in_app = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<models\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
  if going_to_spec
    if in_app
      let new_file = substitute(new_file, '^app/', '', '')
    end
    let new_file = substitute(new_file, '\.e\?rb$', '_spec.rb', '')
    let new_file = 'spec/' . new_file
  else
    let new_file = substitute(new_file, '_spec\.rb$', '.rb', '')
    let new_file = substitute(new_file, '^spec/', '', '')
    if in_app
      let new_file = 'app/' . new_file
    end
  endif
  return new_file
endfunction
nnoremap <leader>. :call OpenTestAlternate()<cr>

set backupdir=$HOME/.vim_backups
set directory=$HOME/.vim_backups

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
  " Indent p tags
  autocmd FileType html,eruby if g:html_indent_tags !~ '\\|p\>' | let g:html_indent_tags .= '\|p\|li\|dt\|dd' | endif
  " Leave the return key alone when in command line windows, since it's used
  " to run commands there.
  autocmd! CmdwinEnter * :unmap <cr>
  autocmd! CmdwinLeave * :call MapCR()
augroup END

" Paste toggle
set pastetoggle=<F2>

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" allow deleting selection without updated clipboard (yank buffer)
vnoremap x "_x

set laststatus=2
set history=500		" command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set cursorline
set hlsearch
set winwidth=83
set winheight=20
set statusline=%<(%{&ft})\ %{fugitive#statusline()}\ %=%-8(%3l,%02c%03V%)(%p%%)\ %f%(%m%)
set wildmode=longest,list
set wildmenu
" Catch trailing whitespace
nmap <leader>sw /\s\+$<CR>
" Show last command
nmap <leader>l :<up>
nmap <leader>2l :<up><up>
set visualbell
set shortmess=AI " Do not warn of existing swap file or show intro
set matchpairs+=<:> " % jumps between carets
"Display a visual barrier for col 80
set colorcolumn=80
"Use confirm instead of aborting an action
set confirm
"Always have lines of context above or below current line
set scrolloff=3

if &t_Co >= 256 && &bg == "dark"
  highlight ColorColumn ctermbg=233
elseif &t_Co >= 256 && &bg != "dark"
  highlight ColorColumn ctermbg=230
else
  highlight ColorColumn ctermbg=8
endif

let g:slimv_swank_cmd = '! xterm -e scheme --load /home/patrick/.vim/bundle/slimv.vim/slime/contrib/swank-mit-scheme.scm &'

"Command-T
let g:CommandTAlwaysShowDotFiles = 1
let g:CommandTAcceptSelectionSplitMap='<C-d>'

"Refactoring (based on ecomba)
nnoremap <leader>it :call InlineTemp()<CR>

" Synopsis:
" Inlines a variable
function! InlineTemp()
" Copy the variable under the cursor into the 'a' register
" XXX: How do I copy into a variable so I don't pollute the registers?
  let original_a = @a
  normal "ayiw

" It takes 4 diws to get the variable, equal sign, and surrounding
" whitespace. I'm not sure why. diw is different from dw in this
" respect.
  normal 4diw
" Delete the expression into the 'b' register
  let original_b = @b
  normal "bd$

" Delete the remnants of the line
  normal dd

" Store current line, that's where we will start searching from
  let current_line = line(".")

" Find the start and end of the current block
" TODO: tidy up if no matching 'def' found (start would be 0 atm)
  let [block_start, block_end] = common#get_range_for_block('\<def\|it\>','Wb')

" Rename the variable within the range of the block
  call common#gsub_all_in_range(current_line, block_end, '\<' . @a . '\>', @b)

" Put back original register contents
  let @a = original_a
  let @b = original_b
endfunction

"MATH
nmap <Leader>me a ∈<Esc>
nmap <Leader>mz a ℤ<Esc>
