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
  call plug#end()
endif

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
set hlsearch
set incsearch 

set hidden
set nojoinspaces
set nonumber 
set norelativenumber
set signcolumn=no
set nocursorline 
set nocursorcolumn
set noshowmode
set noshowcmd
set ruler
set display=lastline
set showtabline=1
set laststatus=1
set scrolloff=0
set shortmess=aAItToOS
set textwidth=0

" set spellcapcheck=
set spelllang=en_us,ru_ru

set splitright
set splitbelow

set nofoldenable
set foldlevelstart=99

set pumheight=10
set complete=.,w
set completeopt-=preview
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

set mouse=

set guifont=Menlo
set guioptions-=m
set guioptions-=r
set guioptions-=T

" ---------------
" Plugin settings
" ---------------
runtime! ftplugin/man.vim
set keywordprg=:Man

let loaded_netrwPlugin=0

let c_comment_strings = 0
unlet c_comment_strings

let g:openbrowser_message_verbosity = 0

" ------------
" Autocommands
" ------------
autocmd FileType * setlocal autoindent nosmartindent nocindent indentexpr=
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
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
nnoremap <silent> <Leader>l :call ToggleOption('spell')<CR>
