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

if filereadable(expand("~/.vim/autoload/plug.vim"))

call plug#begin('~/.local/share/vim/plugins')
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'romainl/vim-cool'
  Plug 'tpope/vim-sleuth'
  Plug 'tyru/open-browser.vim'

  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  " Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " Plug 'puremourning/vimspector'
  " Plug 'aonemd/fmt.vim'
  " Plug 'google/vim-codefmt'
  " Plug 'tpope/fugitive'
  " Plug 'airblade/vim-gitgutter'
  " Plug 'jreybert/vimagit'
call plug#end()

" -----------------
"  Plugin settings
" -----------------
let g:openbrowser_message_verbosity = 0

let g:go_template_autocreate = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0

let g:zig_fmt_autosave = 0

endif

" ------------------
"  General settings
" ------------------
set background=dark
colorscheme x
syntax off

set autoindent
set ignorecase
set smartcase
set hlsearch
set incsearch
set nojoinspaces

" set textwidth=80
" set colorcolumn=+1

set nonumber
set norelativenumber
set cursorcolumn
set nocursorline
set noshowcmd
set noshowmode
set ruler
set laststatus=1
set showtabline=1
set signcolumn=no
set display=lastline

set fillchars=eob:\ ,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:-,fold:-
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:› " precedes:«,extends:»

set shortmess=IAacOoSTt

set hidden

set clipboard=unnamedplus
set guicursor=
set mouse=

set nofoldenable
set foldlevelstart=99

set spelllang=en_us,ru_ru
set spellcapcheck=

set splitright splitbelow

set complete=.
set pumheight=10

set wildmode=longest,list

set nobackup
set noswapfile
set noundofile
set nowritebackup

let c_comment_strings = 0
unlet c_comment_strings

runtime! ftplugin/man.vim
set keywordprg=:Man

let loaded_netrwPlugin=0

" -----------
"  Functions
" -----------
fu! ToggleSetOption(name)
  exec "set " . a:name . "!"
  exec "set " . a:name . "?"
endfu

fu! DiffOrigSh()
 if empty(expand('%'))
   echohl ErrorMsg | echo "No file name" | echohl None
   return
 elseif !filereadable(expand('%'))
   echohl ErrorMsg | echo "Not a file" | echohl None
   return
 endif
 let file = expand('%')
 let edit = '/tmp/vimdiff'
 silent exec "keepalt w! " . edit
 silent exec "!__vimdiff " . file . " " . edit . " 2>/dev/null"
 redraw!
 if v:shell_error == 1
   echo "No changes"
 endif
endfu

" --------------
"  Autocommands
" --------------
au VimEnter * :clearjumps
au VimResized * wincmd =
au FileType * setlocal autoindent nosmartindent nocindent indentexpr=
au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

au CmdwinEnter :syntax clear
au FileType diff syntax enable

" ----------
"  Mappings
" ----------
nnoremap Y y$

nnoremap <Leader>W :silent! w !sudo tee %<CR>:edit!<CR>

nnoremap <expr> <silent> <Leader>d DiffOrigSh()

nnoremap <expr> <Leader>sc ToggleSetOption("ignorecase")
nnoremap <expr> <Leader>sl ToggleSetOption("list")
nnoremap <expr> <Leader>ss ToggleSetOption("spell")
nnoremap <expr> <Leader>sw ToggleSetOption("wrap")

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

nnoremap Q q
nnoremap q <Nop>

nnoremap <C-c> <silent> <C-c>
inoremap <C-Space> <Nop>
cnoremap <S-Tab> <Nop>
inoremap <C-@> <Nop>
nnoremap gd <Nop>
vnoremap gd <Nop>
nnoremap gD <Nop>
vnoremap gD <Nop>
nnoremap K <Nop>
vnoremap K <Nop>

" --------------
"  LSP settings
" --------------
fu! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete

  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nnoremap <buffer> gd <plug>(lsp-definition)

  " nnoremap <buffer> K <plug>(lsp-hover)
  " nnoremap <buffer> <expr><c-j> lsp#scroll(+4)
  " nnoremap <buffer> <expr><c-k> lsp#scroll(-4)
  " " au CursorMoved * call popup_clear()

  au BufWritePre *.go,*.rs call execute('LspDocumentFormatSync')
endfu

augroup lsp_install
  au!
  au User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_hover_conceal = 2
let g:lsp_completion_documentation_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_highlights_enabled =  1
let g:lsp_diagnostics_echo_delay = 100
let g:lsp_diagnostics_signs_enabled = 0
let g:lsp_diagnostics_virtual_text_align = 'after'
let g:lsp_diagnostics_virtual_text_delay = 100
let g:lsp_diagnostics_virtual_text_enabled = 1
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_document_highlight_enabled = 0
let g:lsp_settings_enable_suggestions = 0
let g:lsp_signature_help_enabled = 0
let g:lsp_highlight_references_enabled = 0
