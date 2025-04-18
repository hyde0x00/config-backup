" -------
" Plugins
" -------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  au VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
au VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

if filereadable(expand('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.local/share/vim/plugins')
  Plug 'tyru/open-browser.vim'
  Plug 'tpope/vim-sleuth'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  call plug#end()
endif

" ---------------------------------------------------------------
" https://github.com/vim/vim/issues/10574#issuecomment-1205725448
" ---------------------------------------------------------------
set ttyscroll=0

" ----------------
" General settings
" ----------------
set background=dark
colorscheme nothing
syntax off

set clipboard=unnamedplus

set autoindent 
set nosmartindent
set ignorecase 
set nosmartcase
set incsearch 
set hlsearch
set nonumber 
set norelativenumber
set nocursorline 
set nocursorcolumn
set nojoinspaces
set scrolloff=0

set ruler
set noshowcmd
set noshowmode
set laststatus=1
set shortmess=aAItToOS
set showtabline=1
set signcolumn=no
set display=lastline

set nolist
set fillchars=eob:\ ,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:-,fold:-
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:› " precedes:«,extends:» eol:¬,tab:▸▸,»
" set showbreak=↳\ 

set hidden
set mouse=

set splitright
set splitbelow

" set spellcapcheck=
set spelllang=en_us,ru_ru

set nofoldenable
set foldlevelstart=99

set pumheight=10
set complete=.,w,b,u
set completeopt-=preview

set wildmode=longest,list

set nobackup
set noswapfile
set noundofile
set nowritebackup

set guifont=Menlo
set guioptions-=m
set guioptions-=r
set guioptions-=T

" ---------------
" Plugin settings
" ---------------
let loaded_netrwPlugin=0

runtime! ftplugin/man.vim
set keywordprg=:Man

let c_comment_strings = 0
unlet c_comment_strings

let g:openbrowser_message_verbosity = 0

" ------------
" Autocommands
" ------------
autocmd FileType * setlocal autoindent nosmartindent nocindent indentexpr=
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
autocmd VimEnter * :clearjumps
autocmd VimResized * wincmd =
autocmd CmdwinEnter * set syntax=clear

autocmd BufEnter,BufNewFile,BufRead *.jai set filetype=c

" --------
" Mappings
" --------
nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap <silent> <Leader>W :write !sudo tee %<CR>:edit!<CR>

nnoremap <silent> <expr> <Leader>d DiffOrig()

nnoremap <Leader>f :Find 
nnoremap <Leader>s :Search 
nnoremap <silent> <Leader>F :Find<CR>
nnoremap <silent> <Leader>S :Search<CR>
vnoremap <silent> gr :SearchSelection<CR>
nnoremap <silent> gr :SearchWord<CR>

nnoremap Y y$

nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

nnoremap Q q
nnoremap q <Nop>

nnoremap <C-C> <silent> <C-C>
nnoremap gd <Nop>
vnoremap gd <Nop>
nnoremap K <Nop>
vnoremap K <Nop>
cnoremap <S-TAB> <Nop>
inoremap <C-@> <Nop>
inoremap <C-SPACE> <Nop>

function! ToggleOption(name)
  exec 'set '.a:name.'!'
  exec 'set '.a:name.'?'
endfunction

nnoremap <silent> <Leader>c :call ToggleOption('ignorecase')<CR>
nnoremap <silent> <Leader>w :call ToggleOption('wrap')<CR>
nnoremap <silent> <Leader>v :call ToggleOption('spell')<CR>
