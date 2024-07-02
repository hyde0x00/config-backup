" ------------------------------------------------------------------------------
"  Plugin manager
" ------------------------------------------------------------------------------

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
  Plug 'tyru/open-browser.vim'
  Plug 'romainl/vim-cool'
  Plug 'tpope/vim-sleuth'

  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'

  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

  " Plug 'prabirshrestha/asyncomplete.vim'
  " Plug 'prabirshrestha/asyncomplete-lsp.vim'

  " Plug 'puremourning/vimspector'
  " Plug 'aonemd/fmt.vim'
  " Plug 'google/vim-codefmt'
  " Plug 'tpope/fugitive'
  " Plug 'airblade/vim-gitgutter'
  " Plug 'jreybert/vimagit'
call plug#end()

let g:gutentags_ctags_tagfile = ".tags"
let g:tagbar_compact = 2

let g:openbrowser_message_verbosity = 0

let g:go_template_autocreate = 0
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_textobj_enabled = 0

let g:zig_fmt_autosave = 0

endif

" ------------------------------------------------------------------------------
"  General settings
" ------------------------------------------------------------------------------

set background=dark
colorscheme x
syntax off

set hidden
set mouse=

set clipboard=unnamedplus

set autoindent
set ignorecase 
set smartcase
set hlsearch 
set incsearch
set nojoinspaces

set nonumber
set norelativenumber
set nocursorline
set cursorcolumn
set noshowmode
set ruler
set laststatus=1
set showtabline=1
set signcolumn=no
set display=lastline

" set textwidth=80
" set colorcolumn=+1

set nofoldenable
set splitright splitbelow
set shortmess=IAacOoSTt
set wildmode=longest,list

set fillchars=eob:\~,stl:\ ,stlnc:\ ,lastline:\ ,vert:\│,diff:╱,fold:-
set listchars=eol:\ ,tab:\¦\ ,space:\·,trail:·,nbsp:\_,precedes:‹,extends:›
" precedes:«,extends:»

" help cpt
set complete=. " current buffer

set pumheight=10

set tags+=.tags

set spelllang=en_us,ru_ru
set spellcapcheck=

set noswapfile
set nobackup
set nowritebackup

let loaded_netrwPlugin=0

runtime! ftplugin/man.vim
set keywordprg=:Man

let c_comment_strings = 0
unlet c_comment_strings

" ------------------------------------------------------------------------------
"  Functions
" ------------------------------------------------------------------------------

fu! Diff()
  if empty(expand('%'))
    echohl ErrorMsg | echo "No file name" | echohl None | return
  endif
  if !filereadable(expand('%'))
    echohl ErrorMsg | echo "Not a file" | echohl None | return
  endif
  silent keepalt w! /tmp/_vim_diff
  silent exec "!_vim_diff '%'"
  redraw!
  if v:shell_error == 1
    echo "Not edited"
  endif
endfu

command! Diff call Diff()
nnoremap <silent> <Leader>d :Diff<CR>

fu! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfu

nnoremap <Leader>? :call SynGroup()<CR>

" ------------------------------------------------------------------------------
"  Autocommands
" ------------------------------------------------------------------------------

au FileType * setlocal formatoptions-=c 
au FileType * setlocal formatoptions-=r 
au FileType * setlocal formatoptions-=o
au FileType * setlocal nosmartindent nocindent indentexpr=
au VimEnter * :clearjumps
au VimResized * wincmd =

au CmdwinEnter :syntax clear 
au FileType diff syntax enable

au BufEnter,BufNew *.jai setlocal filetype=c " sleuth detection

" ------------------------------------------------------------------------------
"  Mappings
" ------------------------------------------------------------------------------

nnoremap <C-c> <silent> <C-c>
nnoremap gd <Nop>
nnoremap gD <Nop>
nnoremap K <Nop>
vnoremap gd <Nop>
vnoremap gD <Nop>
vnoremap K <Nop>
inoremap <C-Space> <Nop>
inoremap <C-@> <Nop>
cnoremap <S-Tab> <Nop>

nnoremap Q q
nnoremap q <Nop>

nnoremap Y y$

nnoremap <Leader>W :silent! w !sudo tee %<CR>:edit!<CR>

nnoremap <Leader>sc :set ignorecase!<CR>:set ignorecase?<CR>
nnoremap <Leader>ss :set spell!<CR>:set spell?<CR>
nnoremap <Leader>sw :set wrap!<CR>:set wrap?<CR>
nnoremap <Leader>sl :set list!<CR>:set list?<CR>

nnoremap gx <Plug>(openbrowser-smart-search)
vnoremap gx <Plug>(openbrowser-smart-search)

vnoremap gl !lingvo<CR>:redraw!<CR>

" ------------------------------------------------------------------------------
"  LSP settings
" ------------------------------------------------------------------------------

fu! s:on_lsp_buffer_enabled() abort
  setlocal omnifunc=lsp#complete

  if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

  nnoremap <buffer> gd <plug>(lsp-definition)

  au BufWritePre *.go,*.rs call execute('LspDocumentFormatSync')
  au CursorMoved * call popup_clear()
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
