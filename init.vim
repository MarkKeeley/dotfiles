"Using vim-plug so need to run :PlugInstall to auto get plugins

"Remember to use :GoInstallBinaries inside vim to get all needed
"Go programs on a fresh computer!!!

call plug#begin()
" THE Go + Vim plugin
Plug 'fatih/vim-go'
" Nice theme
Plug 'tomasr/molokai'
"File Explorer
Plug 'scrooloose/nerdtree'
"List vars/funcs/etc
Plug 'majutsushi/tagbar'
"Helpful finder
Plug 'ctrlpvim/ctrlp.vim'
call plug#end()

"Set color theme
colorscheme molokai

"Set shortcut key to spacebar
let mapleader = "\<space>"

"auto save file when calling :GoBuild
set autowrite

"Shortcuts for go run
autocmd FileType go nmap <leader>gr  <Plug>(go-run)

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>

"Use goimports when saving files instead of gofmt
let g:go_fmt_command = "goimports"

"Don't show any errors when saving files
let g:go_fmt_fail_silently = 1

"Use camelCase instead of snake_case
let g:go_snippet_case_type = "camelcase"

"Enable vim-go highlighting
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

"Set Go files to use '1 tab = 4 spaces' rules
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

"Run these checkers in a quickfix list
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']

"Call checkers when saving file
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint']

"Prevent :GoMetaLinter from running for too long (5 seconds)
let g:go_metalinter_deadline = "5s"

"Call :GoInfo automatically - auto show info of what cursor is on
let g:go_auto_type_info = 1
"Make vim update time faster for better responsiveness
set updatetime=100

"vim-go auto highlight matching identifiers
let g:go_auto_sameids = 1

" Show line numbers
set number

"Show (partial) command in status line
set showcmd

"Show current mode
set showmode

"Sensible splitting defaults
set splitbelow
set splitright

"Show matching brackets
set showmatch

"Highlight search results
"set hlsearch "This got annoying quickly
"Ignore case when searching
set ignorecase
"Unless query has capital letters
set smartcase
"Start searching as soon as you start typing
set incsearch

" highlight current line
set cursorline

"Allow mouse clicks to change cursor position
set mouse=a
behave mswin

"Load filetype specific indent files
filetype indent on

"visual autocomplete for command menu
set wildmenu

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

"Go up/down more lines when scrolling
set scrolloff=5

"Shortcuts for dealing with buffers
":nmap <leader>b :ls<CR>
:nmap <leader>bl :ls<CR>
:nmap <leader>bn :bnext<CR>
:nmap <leader>bp :bprev<CR>
:nmap <leader>bd :bd<CR>

"Toggle NerdTree
map <F9> :NERDTreeToggle<CR>
:nmap <leader>nt :NERDTreeToggle<CR>

"Open NerdTree automatically if no files were specified
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"Close vim if only window left open is NerdTree
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"Highlight 80th column
set colorcolumn=80 

" Always show status bar
set laststatus=2

"Keep undisplayed buffers
set hidden 

"Set tagbar to appear on left side of screen
let g:tagbar_left = 1

"Set tagbar plugin width
let g:tagbar_width = 28 

"Toggle tagbar
nnoremap <F8> :TagbarToggle<CR>
nnoremap <leader>tb :TagbarToggle<CR>

"So it seems vim-go's compiler errors aren't actually in the quickfix but 
"instead in the Location List
"map <leader>gn :lnext<CR>
"map <leader>gp :lprevious<CR>
"nnoremap <leader>gc :lclose<CR>
"nnoremap <leader>go :lopen<CR>

"Set it so neovim using quickfix instead of location list
if has('nvim')
	let g:go_list_type = "quickfix"
endif

map <leader>gn :cn<CR>
map <leader>gp :cp<CR>
nnoremap <leader>gc :cclose<CR>
nnoremap <leader>go :copen<CR>

"Tell CtrlP to ignore certain file types
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend|pdf|mkv|epub|img|iso|opml|gif|jpg|png|bmp|AppImage|zip|jpeg|wma|flac|mp4|ttf)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'

"Use CtrlP to list buffers
nnoremap <leader>b :CtrlPBuffer<CR>

"Use CtrlP to open files
nnoremap <leader>f :CtrlP<CR>

"Use CtrlP to open most recently used
nnoremap <leader>; :CtrlPMRU<CR>

"Go Back to command mode without hitting ESC key
"inoremap jk <ESC>
"inoremap jj <ESC>

"Needed to get rid of the preview window when using omnicomplete
"commenting out for better method below
"autocmd CompleteDone * pclose

"Remove preview window when leaving insert mode
augroup GoAwayPreviewWindow
autocmd! InsertLeave * wincmd z
augroup end

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

"remap j&k so they go up and down visual lines not physical lines, 
"basically more sensible dealings with wordwrap. Just trying to tame 
"even more wonky vim behavior
nnoremap k gk
nnoremap j gj
nnoremap gk k
nnoremap gj j

"remap arrow keys for now to force the hjkl habbit
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" Make vim treat all .md files as markdown
autocmd BufRead,BufNew *.md setf markdown
" Set wordwrap for markdown files
autocmd Filetype markdown setlocal wrap
autocmd Filetype markdown setlocal linebreak

"Auto open Tagbar when using Go files
"autocmd BufEnter *.go nested TagbarOpen
