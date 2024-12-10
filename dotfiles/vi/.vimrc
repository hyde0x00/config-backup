" ----------------
"  Plugin manager
" ----------------
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
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'tyru/open-browser.vim'
  Plug 'romainl/vim-cool'
  Plug 'tpope/vim-sleuth'
  call plug#end()
endif

" ------------------
"  General settings
" ------------------
if executable("xsel")
  function! PreserveClipboard()
    call system("xsel -ib", getreg('+'))
  endfunction
  function! PreserveClipboadAndSuspend()
    call PreserveClipboard()
    suspend
  endfunction
  autocmd VimLeave * call PreserveClipboard()
  nnoremap <silent> <c-z> :call PreserveClipboadAndSuspend()<cr>
  vnoremap <silent> <c-z> :<c-u>call PreserveClipboadAndSuspend()<cr>
endif

set clipboard=unnamedplus

syntax off
colorscheme x
set background=dark

set autoindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set nojoinspaces
set nonumber
set norelativenumber
set nocursorline
set nocursorcolumn

set hidden

set noshowmode
set ruler
set noshowcmd
set laststatus=1
set showtabline=1
set signcolumn=no
set shortmess=aAItToOS
set display=lastline

set mouse=

set splitright splitbelow

set spelllang=en_us,ru_ru
set spellcapcheck=

set nofoldenable
set foldlevelstart=99

set wildmode=longest,list

set complete=.,w,b,u
set pumheight=10

set nolist
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:› " precedes:«,extends:»
set fillchars=eob:\ ,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:-,fold:-

set nobackup
set noswapfile
set noundofile
set nowritebackup

set guioptions-=m
set guioptions-=r
set guioptions-=T

set guifont=Menlo

" -----------------------------------------------------------------
"  https://github.com/vim/vim/issues/10574#issuecomment-1205725448
" -----------------------------------------------------------------
set ttyscroll=0

" -----------------
"  Plugin settings
" -----------------
let loaded_netrwPlugin=0

runtime! ftplugin/man.vim
set keywordprg=:Man

let c_comment_strings = 0
unlet c_comment_strings

let g:openbrowser_message_verbosity = 0

" --------------
"  Autocommands
" --------------
au FileType * setlocal autoindent nosmartindent nocindent indentexpr=
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au VimEnter * :clearjumps
au VimResized * wincmd =

au CmdwinEnter * set syntax=clear
au BufEnter,BufNewFile,BufRead *.jai set filetype=c

" -----------
"  Functions
" -----------
function! ToggleOption(name)
  let column = getpos('.')[2]
  exec 'set '.a:name.'!'
  exec 'set '.a:name.'?'
  call feedkeys(column.'|')
endfunction

function! Err(message)
  echohl ErrorMsg | echo a:message | echohl None
endfunction

function! Warn(message)
  echohl WarningMsg | echo a:message | echohl None
endfunction

function! DiffOrig()
  let filename = expand('%')
  if empty(filename)
    return Err('No file name')
  elseif !filereadable(filename)
    return Err('Not a file')
  endif
  let file = fnameescape(filename)
  let edit = tempname()
  silent execute 'keepalt write! '.edit
  let is_diff = system('diffcolor -q '.file.' '.edit)
  if empty(is_diff)
    call Warn('No changes')
  else
    silent execute '!diffcolor -p '.file.' '.edit
    silent !clear -x
    redraw!
  endif
  call delete(edit)
endfunction

function! FzfOpener(shell_cmd, field_count, ...)
  let common_flags = '-p -q'
  if a:0 > 0
    let args = join(map(map(copy(a:1), 
      \ 'substitute(v:val, "^\\~", $HOME, "")'), 
      \ 'shellescape(v:val)'), ' ')
  else
    let args = ''
  endif
  let result = system(a:shell_cmd.' '.common_flags.' '.args)[0:-2]
  silent !clear -x
  redraw!
  if empty(result)
    return Warn('Nothing found')
  endif
  if &modified && !&hidden
    return Err('E37: No write since last change')
  endif
  let fields = split(result, ':')
  let filename = fields[0]
  let file = fnameescape(filename)
  if bufexists(bufname(file))
    silent execute 'buffer! '.bufnr(file)
  endif
  if a:field_count == 1
    execute 'edit! '.file
  elseif a:field_count >= 2
    let line_number = fields[1]
    execute 'edit! +'.line_number' '.file
  endif
endfunction

function! FzfFind(...)
  let cmd = 'f'
  if !executable(cmd)
    return Err('Executable not found: '.cmd)
  endif
  call FzfOpener(cmd, 1, a:000)
endfunction

function! FzfSearch(...)
  let cmd = 's'
  if !executable(cmd)
    return Err('Executable not found: '.cmd)
  endif
  call FzfOpener(cmd, 2, a:000)
endfunction

function! FzfSearchWord()
  let word = expand('<cword>')
  if empty(word)
    return Err('Nothing under cursor')
  endif
  call FzfSearch('-w', word)
endfunction

function FzfSearchSelection() range
  let grep_special = '^$.*[]\'
  let p = getpos("'<")[2] - 1
  let q = getpos("'>")[2] - 1
  let selection = escape(getline(line('.'))[p:q], grep_special)
  if empty(selection)
    return Err('Nothing selected')
  endif
  call FzfSearch(selection)
endfunction

command! DiffOrig call DiffOrig()

command! -nargs=* -complete=dir Find call FzfFind(<f-args>)
command! -nargs=* -complete=file Search call FzfSearch(<f-args>)
command! SearchWord call FzfSearchWord()
command! -range SearchSelection call FzfSearchSelection()

" ----------
"  Mappings
" ----------
nnoremap <silent> <C-L> :nohl<CR><C-L>

nnoremap <silent> <Leader>W :write !sudo tee %<CR>:edit!<CR>
nnoremap <silent> <expr> <Leader>d DiffOrig()

nnoremap <Leader>f :Find 
nnoremap <silent> <Leader>F :Find<CR>
nnoremap <Leader>s :Search 
nnoremap <silent> <Leader>S :Search<CR>
nnoremap <silent> gr :SearchWord<CR>
xnoremap <silent> gr :SearchSelection<CR>

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap <expr> <Leader>c ToggleOption('ignorecase')
nnoremap <expr> <Leader>C ToggleOption('spell')
nnoremap <expr> <Leader>w ToggleOption('wrap')

nnoremap Y y$

nnoremap Q q
nnoremap q <Nop>

nnoremap <C-C> <silent> <C-C>
inoremap <C-SPACE> <Nop>
cnoremap <S-TAB> <Nop>
inoremap <C-@> <Nop>
nnoremap gd <Nop>
vnoremap gd <Nop>
nnoremap K <Nop>
vnoremap K <Nop>
