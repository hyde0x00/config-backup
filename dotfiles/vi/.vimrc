" -------
" Plugins
" -------
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'

if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
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

" ---------------------------------------------------------------------------
" Scrolling redraw tearing/flicker fix:
" https://github.com/vim/vim/issues/10574#issuecomment-1205725448
"
" Setting ttyscroll to 0 fixes Ctrl-U and Ctrl-D.
" Setting any color except NONE for Normal ctermbg fixes Ctrl-F.
"
" Enabling showcmd seems to fix both of those at once.
" ---------------------------------------------------------------------------
set ttyscroll=0

" ----------------
" General settings
" ----------------
set background=dark
colorscheme nothing
syntax off

set autoindent
set nosmartindent
set ignorecase
set smartcase
set incsearch
set nohlsearch

set mouse=
set hidden
set nojoinspaces
set nonumber
set norelativenumber
set scrolloff=0
set signcolumn=no
set nocursorline
set nocursorcolumn

set textwidth=0
set wrapmargin=0

set ruler
set noshowmode
set noshowcmd
set shortmess=aAcCItToOS
set display=lastline
set showtabline=1
set laststatus=1

set spelllang=en_us,ru_ru
" set spellcapcheck=

set splitright
set splitbelow

set nofoldenable
set foldlevelstart=99

set cot-=preview
set cpt=.,w,b,u

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

set guifont=Menlo
set guioptions-=m
set guioptions-=r
set guioptions-=T

" ---------------
" Plugin settings
" ---------------
let g:loaded_netrwPlugin = 1

runtime! ftplugin/man.vim
set keywordprg=:Man

let g:openbrowser_message_verbosity = 0

let g:linelengthlimit = 80
let g:highlight_linelength = 0
let g:highlight_matchparen = 0
let g:highlight_whitespace = 0

" ------------
" Autocommands
" ------------
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o formatoptions-=t
autocmd FileType * setlocal autoindent nosmartindent nocindent indentexpr=

autocmd CmdwinEnter * set syntax=clear
autocmd VimEnter * :clearjumps
autocmd VimResized * wincmd =

autocmd BufEnter,BufNewFile,BufRead *.jai set filetype=c

" --------
" Mappings
" --------
nnoremap <C-C> <silent> <C-C>
nnoremap gd <Nop>
vnoremap gd <Nop>
nnoremap K <Nop>
vnoremap K <Nop>
inoremap <C-@> <Nop>
inoremap <C-SPACE> <Nop>
cnoremap <S-TAB> <Nop>

nnoremap Q q
nnoremap q <Nop>

nnoremap Y y$

nnoremap gy "+y
vnoremap gy "+y

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
nnoremap <silent> <expr> <Leader>d DiffOrig()
nnoremap <silent> <Leader>W :write !sudo tee %<CR>:edit!<CR>

nnoremap <Leader>f :Find 
nnoremap <Leader>s :Search 
nnoremap <silent> <Leader>F :Find<CR>
nnoremap <silent> <Leader>S :Search<CR>
nnoremap <silent> gr :SearchWord<CR>
vnoremap <silent> gr :SearchSelection<CR>

function! ToggleOption(name)
  exec 'set '.a:name.'!'
  exec 'set '.a:name.'?'
endfunction

nnoremap <silent> <Leader>c :call ToggleOption('ignorecase')<CR>
nnoremap <silent> <Leader>l :call ToggleOption('spell')<CR>
nnoremap <silent> <Leader>w :call ToggleOption('wrap')<CR>
nnoremap <silent> <Leader>m :call ToggleOption('magic')<CR>
