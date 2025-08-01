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
  Plug 'tpope/vim-sleuth'
  Plug 'tyru/open-browser.vim'
  call plug#end()
endif

" ----------------
" General settings
" ----------------
set clipboard=unnamedplus

set background=dark
colorscheme nothing
syntax off

set hlsearch
set incsearch
set ignorecase
set smartcase
set autoindent
set nosmartindent

set mouse=
set hidden
set nojoinspaces
set nonumber
set norelativenumber
set scrolloff=0
set signcolumn=no
set nocursorline
set nocursorcolumn
set ruler
set noshowmode
set noshowcmd
set shortmess=aAcCItToOS
set display=lastline
set showtabline=1
set laststatus=1
set textwidth=0

set spelllang=en_us,ru_ru
" set spellcapcheck=

set splitright
set splitbelow

set nofoldenable
set foldlevelstart=99

set complete=.,w,b,u
set completeopt-=preview
set pumheight=10

set wildmode=longest,list

set nolist
set fillchars=eob:\ ,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:-,fold:-
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:› " precedes:«,extends:» eol:¬,tab:▸▸,»
" set showbreak=↳\ 

set nobackup
set noswapfile
set noundofile
set nowritebackup

" ---------------------------------------------------------------------------
" Scrolling redraw flicker fix:
" https://github.com/vim/vim/issues/10574#issuecomment-1205725448
"
" Setting ttyscroll to 0 fixes Ctrl-U and Ctrl-D.
" Setting any color except NONE for Normal background (ctermbg) fixes Ctrl-F.
" Enabling showcmd seems to fix both of the above.
" ---------------------------------------------------------------------------
set ttyscroll=0

set guifont=Menlo
set guioptions-=m
set guioptions-=r
set guioptions-=T

" ---------------
" Plugin settings
" ---------------
let g:openbrowser_message_verbosity = 0

let g:loaded_netrwPlugin = 1

runtime! ftplugin/man.vim
set keywordprg=:Man

" ------------
" Autocommands
" ------------
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
autocmd FileType * setlocal autoindent nosmartindent nocindent indentexpr=

autocmd VimResized * wincmd =
autocmd VimEnter * :clearjumps
autocmd CmdwinEnter * set syntax=clear

autocmd BufEnter,BufNewFile,BufRead *.jai set filetype=c

" --------
" Mappings
" --------
nnoremap Y y$

nnoremap Q q
nnoremap q <Nop>

nnoremap <silent> <Leader>W :write !sudo tee %<CR>:edit!<CR>

nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap <silent> <expr> <Leader>d DiffOrig()

nnoremap <Leader>f :Find 
nnoremap <Leader>s :Search 
nnoremap <silent> <Leader>F :Find<CR>
nnoremap <silent> <Leader>S :Search<CR> 
vnoremap <silent> gr :SearchSelection<CR>
nnoremap <silent> gr :SearchWord<CR>

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
nnoremap <silent> <Leader>l :call ToggleOption('spell')<CR>
nnoremap <silent> <Leader>w :call ToggleOption('wrap')<CR>
nnoremap <silent> <Leader>m :call ToggleOption('magic')<CR>
