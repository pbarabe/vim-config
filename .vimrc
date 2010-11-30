" ===================================
" s.py .vimrc config
" contact: py.stephane1(at)gmail.com
" ===================================

" Include user's local vim config
if filereadable(expand("~/.vim/vimrc"))
  source ~/.vim/vimrc
endif

if filereadable(expand("~/.vim/php-doc.vim"))
    source ~/.vim/php-doc.vim
endif

set cursorline
set encoding=utf-8

set nocompatible
set nobackup " delete backup
set backspace=indent,eol,start " allow backspacing over everything in insert mode

set history=50	 " keep 50 lines of command line history
set ruler		 " show the cursor position all the time
set showcmd		 " display incomplete commands
set incsearch    " do incremental searching

set expandtab
set shiftwidth=4 "nombre d'espace apres un '>>'"
set tabstop=4    "nombre de place que prend une tabulation"

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

" awesome stuff on MacVim
if has("gui_macvim")
    set go-=T " Disable toolbar on MacVim
    colorscheme symfony 
endif

let php_htmlInStrings=1 " to highlight HTML in string
let php_noShortTags = 1 " to disable short tags
"let php_folding = 1 " to enable folding for classes and functions

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>


"oNLy do this part when compiled with support for autocommands.
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
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"run file with PHP CLI (CTRL-M)
":autocmd FileType php noremap <C-M> :w!<CR>:!/usr/bin/php %<CR>
"
"" PHP parser check (CTRL-L)
:autocmd FileType php noremap <C-L> :!/usr/bin/php -l %<CR>

noremap <C-P> :set paste<CR>:call PhpDoc()<CR>:set nopaste<CR>
"(I have ~/bin/php as my PHP interpreter, which allows me to run PHP with a
""custom config file, as well as to change which PHP binary I'm using.)