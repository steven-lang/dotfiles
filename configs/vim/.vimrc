set hidden
set noshowmode

" don't give |ins-completion-menu| messages.
set shortmess+=c

" Disable folds
set nofoldenable

" Better display for messages
set cmdheight=2

" Always show the last 5 lines
set scrolloff=5

" always show signcolumns
set signcolumn=yes
set clipboard=unnamedplus

" Use global replace by default (/g) to revert
set gdefault
" Set fixed popup menu height
set pumheight=8

" Avoid escape
imap jj <ESC>

if has('nvim')
  " Use pum as wildmenu
  " set wildoptions=pum
  " Enable incremental commands (e.g. search-replace preview)
  set inccommand=split
endif


" Enable automatic indentation
set autoindent 
filetype plugin indent on    " required

" Reload .vimrc on save
autocmd! bufwritepost .vimrc source %

" Autoinstall Plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')
" Filetree
Plug 'scrooloose/nerdtree'

" CUDA
Plug 'bfrg/vim-cuda-syntax'

" Overleaf vim
Plug 'da-h/AirLatex.vim'

" DAP Plugin
Plug 'puremourning/vimspector'

" Make screenshots of code
Plug 'segeljakt/vim-silicon'

" Control Shift S
Plug 'dyng/ctrlsf.vim'

" Match-Up: vim matchit alternative
Plug 'andymass/vim-matchup'

" Disable search highligh when done searching
Plug 'romainl/vim-cool'

" Additional targets
Plug 'wellle/targets.vim'

" Python docstrings
Plug 'kkoomen/vim-doge'

" Python semantic highlighting
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Vim session handling made easy
Plug 'thaerkh/vim-workspace'

" CoC vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" Hex color preview
Plug 'norcalli/nvim-colorizer.lua'

" Bracket autocomplete
Plug 'jiangmiao/auto-pairs'

" Gruvbox colorscheme
Plug 'gruvbox-community/gruvbox'
Plug 'mhartington/oceanic-next'

" USE cgn with dot repeat instead ///Enable multiple cursors with <C-n> in visual mode
Plug 'terryma/vim-multiple-cursors'

" Python autoimport
Plug 'mgedmin/python-imports.vim'

" Tex
Plug 'lervag/vimtex'

" Easier vim navigation
Plug 'easymotion/vim-easymotion'

" Quoting/paranthesizing made simple
Plug 'tpope/vim-surround'

" Vim git integration
Plug 'tpope/vim-fugitive' " Git commands
Plug 'airblade/vim-gitgutter' " Git info on the sidebar
Plug 'rhysd/committia.vim' " Git commit extension

" Comment/uncomment with gc
Plug 'tpope/vim-commentary'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Sensible vim config
Plug 'tpope/vim-sensible'

" CTag automation
Plug 'ludovicchabant/vim-gutentags'

" Advanced syntax highlighting
Plug 'sheerun/vim-polyglot'

" Statusline
Plug 'itchyny/lightline.vim'

" Julia support
Plug 'JuliaEditorSupport/julia-vim'

" UltiSnips
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Add repeat support for plugins
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'

" Sidebar with tags
Plug 'liuchengxu/vista.vim'

" Initialize plugin system
call plug#end()


"Credit joshdick
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" General vim config {{{
" Set leader key to <space> 
:let mapleader = ' '      " Leader key
:let maplocalleader = ',' " Local leader key

syntax on                 " Enable syntax highlighting
" let g:gruvbox_italic=1
" let g:gruvbox_bold=1
" let g:gruvbox_contrast_dark='soft'
" let g:gruvbox_contrast_light='medium'
set background=dark
let g:oceanic_next_terminal_bold = 1
let g:oceanic_next_terminal_italic = 1"
colorscheme OceanicNext
set path=.,,**
set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
set number                " Enable numbers
set relativenumber        " Enable relative numbers
set showcmd               " Show command in bottom right position
set cursorline            " Highlight line where curser is
" set colorcolumn=100
set wildmenu
set showmatch
set incsearch             " Enable incremental seach; Highlight while typing
set ignorecase            " Ignore case for searches; temp undo with /\c or /\C

" Allow for visual movements over wrapped lines
nnoremap j gj
nnoremap k gk

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Duplicate line and comment out the upper one
nmap yp Ypkgccj

" Keep visual mode while indenting
vnoremap < <gv
vnoremap > >gv
" }}}

" {{{ Vista Vim 
function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

" }}}

" Lightline {{{
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], ['cocstatus', 'gitbranch', 'readonly', 'relativepath', 'modified'] ],
      \   'right' : [ ['lineinfo'], ['percent']]
      \ },
      \ 'colorscheme': 'oceanicnext',
      \ 'component_function': {
      \   'gitbranch' : 'fugitive#head', 
      \   'cocstatus': 'coc#status',
      \   'method': 'NearestMethodOrFunction',
      \ }
      \ }

let g:lightline.separator = {
      \   'left': '', 'right': ''
      \}
let g:lightline.subseparator = {
      \   'left': '', 'right': '' 
      \}
" }}}

" FZF {{{
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'Ignore'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }
" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()
" }}}


" Use arrow keys for resizing
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" EasyMotion {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" }}}

" Customize fzf colors to match your color scheme
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Disable trailing spaces warning
let g:python_highlight_space_errors=0

" LaTeX {{{
" Disable latex-box from polyglot dependency to make vimtex usable
let g:polyglot_disabled = ['latex', 'markdown']

let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'


" LaTeX bindings {{{
augroup latexbindings
  autocmd! latexbindings
  autocmd Filetype tex inoremap <buffer> <silent> _ _{}<Left>
  autocmd Filetype tex inoremap <buffer> <silent> ^ ^{}<Left>

  autocmd BufWritePost *.tex execute ':!pdflatex homework.tex'
augroup end
" }}}


" Run make on <F9>
nnoremap <F9> :make<CR>

" Python bindings {{{
augroup pythonbindings
  autocmd! pythonbindings
  " Run python file
  autocmd Filetype python set makeprg=python\ %

  " Insert debugging with ipdb
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>b :call InsertIPDB()<CR>

  " Python import
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>i     :ImportName<CR>

  " use `:OR` for organize import of current buffer
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

  " Organize imports
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>o :OR<CR>

  " autocmd Filetype python vnoremap <buffer> <silent> <localleader>d :'<,'>GenPyDoc<CR>
  " Function to insert python IPDB debug line
  function! InsertIPDB()
    let trace = expand("__import__(\"ipdb\").set_trace(context=13)")
    execute "normal O".trace
  endfunction
augroup end
" }}}

" UtilSnips {{{
let g:UltiSnipsExpandTrigger = '<c-s>'
let g:UltiSnipsJumpForwardTrigger = '<c-b>'
let g:UltiSnipsJumpBackwardTrigger = '<c-z>'
let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:ultisnips_python_style="google"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}


" CTRL-C doesn't trigger the InsertLeave autocmd . map to <ESC> instead.
inoremap <c-c> <ESC>


" Delte backwards in insert mode
noremap! <C-BS> <C-w>
noremap! <M-BS> <C-w>
inoremap <C-w> <C-\><C-o>dB
inoremap <C-BS> <C-\><C-o>db


" Add surroundings in visual mode and insert
vmap s) S)i
vmap s( S)i
vmap s] S]i
vmap s[ S]i
vmap s{ S}i
vmap s} S}i

" " ALE config {{{
" " Ale fixers
" let g:ale_fixers = ['black'] 
" let g:ale_python_black_options = '-l 100' 
" " let g:ale_fix_on_save = 1

" " Highlights
" let g:ale_set_highlights = 0

" let g:ale_linters = {
" \   'python': ['flake8'],
" \}

" let g:ale_echo_msg_error_str = 'E'
" let g:ale_echo_msg_warning_str = 'W'
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" " Lint always in Normal Mode
" let g:ale_lint_on_text_changed = 'normal'
" " Lint when leaving Insert Mode but don't lint when in Insert Mode 
" let g:ale_lint_on_insert_leave = 1
" " }}}

" Leader mappings {{
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>L :BLines<CR>
nnoremap <silent> <Leader>T :BTags<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader>/ :Ag<CR>
nnoremap <Leader>cc :Format<CR>

" Jump motions
map  <Leader>w <Plug>(easymotion-bd-w)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map s <Plug>(easymotion-s2)
" }}

" Center after search {{{
nnoremap n nzz
nnoremap N Nzz
" }}}

" Vim workspace {{{
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_autosave = 0
let g:workspace_autosave_untrailspaces = 0
" }}}

" Vim cool{{{
let g:CoolTotalMatches = 1
" }}}

" function! s:check_back_space() abort "{{{
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ deoplete#manual_complete()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" " Deoplete {{{
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#enable_ignore_case = 1
" let g:deoplete#enable_smart_case = 1
" let g:deoplete#sources#jedi#enable_typeinfo = 1
" let g:deoplete#sources#jedi#show_docstring = 1
" " Disable autocompletion (using deoplete instead)
" let g:jedi#completions_enabled = 0
" set completeopt-=preview
" let g:python_host_prog = '/usr/bin/python'
" let g:python3_host_prog = '/usr/bin/python3'
" " }}}
" " Echodoc {{{
" let g:echodoc#enable_at_startup = 1
" let g:echodoc#type = "floating"
" " }}}

" " Jedi {{{
" let g:jedi#rename_command = "<leader>r"
" let g:jedi#auto_close_doc = 1
" let g:jedi#usages_command = "gu"
" let g:jedi#goto_command = "gd"
" " Disable since deoplete is enabled
" let g:jedi#auto_initialization = 1
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:jedi#smart_auto_mappings = 0
" let g:jedi#popup_on_dot = 0
" let g:jedi#completions_command = ""
" let g:jedi#show_call_signatures = "1"
" let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
" " }}}

if has('nvim')
  lua require'colorizer'.setup()
endif


" Custom semshi Highlights {{{
function! CustomSemshiHighlightsGruvbox()
  hi semshiLocal           ctermfg=208 guifg=#fe8019
  hi semshiGlobal          ctermfg=172 guifg=#d79921
  hi semshiImported        ctermfg=172 guifg=#d79921 gui=NONE
  hi semshiParameter       ctermfg=109 guifg=#83a598
  hi semshiParameterUnused ctermfg=108 guifg=#7c6f64 cterm=underline gui=underline
  hi semshiFree            ctermfg=176 guifg=#d3869b
  hi semshiBuiltin         ctermfg=132 guifg=#b16286
  hi semshiAttribute       ctermfg=108 guifg=#8ec07c
  hi semshiSelf            ctermfg=248 guifg=#bdae93
  hi semshiUnresolved      ctermfg=166 guifg=#d65d0e cterm=underline gui=underline
  hi semshiSelected        ctermfg=230 guifg=#f9f5d7 ctermbg=237 guibg=#504945

  hi semshiErrorSign       ctermfg=230 guifg=#f9f5d7 ctermbg=124 guibg=#fb4934
  hi semshiErrorChar       ctermfg=230 guifg=#f9f5d7 ctermbg=124 guibg=#fb4934
  sign define semshiError text=E> texthl=semshiErrorSign
endfunction

function! CustomSemshiHighlightsOceanicNext()
  hi semshiLocal           ctermfg=208 guifg=#f99157
  hi semshiGlobal          ctermfg=172 guifg=#fac863
  hi semshiImported        ctermfg=172 guifg=#fac863 gui=NONE
  hi semshiParameter       ctermfg=109 guifg=#c594c5
  hi semshiParameterUnused ctermfg=108 guifg=#65737e cterm=underline gui=underline
  hi semshiFree            ctermfg=176 guifg=#c594c5
  hi semshiBuiltin         ctermfg=132 guifg=#6699cc
  hi semshiAttribute       ctermfg=108 guifg=#c594c5
  hi semshiSelf            ctermfg=248 guifg=#5fb3b3
  hi semshiUnresolved      ctermfg=166 guifg=#ec5f67 cterm=underline gui=underline
  hi semshiSelected        ctermfg=230 guifg=#cdd3de ctermbg=237 guibg=#65737E

  hi semshiErrorSign       ctermfg=230 guifg=#cdd3de ctermbg=124 guibg=#ec5f67
  hi semshiErrorChar       ctermfg=230 guifg=#cdd3de ctermbg=124 guibg=#ec5f67
  sign define semshiError text=E> texthl=semshiErrorSign
endfunction

autocmd filetype python call CustomSemshiHighlightsOceanicNext()
" }}}

" Doge document generator {{{
let g:doge_doc_standard_python = 'google'
let g:doge_mapping='<Leader>d'
" }}}

" Silicon {{{
let g:silicon = {
      \ 'theme':              'TwoDark',
      \ 'font':                  'Hack',
      \ 'background':         '#7c6f64',
      \ 'shadow-color':       '#555555',
      \ 'line-pad':                   2,
      \ 'pad-horiz':                 10,
      \ 'pad-vert':                 20,
      \ 'shadow-blur-radius':         0,
      \ 'shadow-offset-x':            0,
      \ 'shadow-offset-y':            0,
      \ 'line-number':           v:true,
      \ 'round-corner':          v:true,
      \ 'window-controls':       v:false,
      \ }
" }}}


" Gradle syntax highlighting
au BufNewFile,BufRead *.gradle setf groovy

" CoC Vim {{{
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" Extensions
let g:coc_global_extensions=['coc-tag', 'coc-python', 'coc-json', 'coc-pairs']

" Remap for do codeAction of current line
nmap <leader>ca  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>cf  <Plug>(coc-fix-current)

" Navigate diagnostics
nmap <silent> <leader>cdp <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>cdn <Plug>(coc-diagnostic-next)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

" Use auocmd to force lightline update
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

function! CocstatusCustom()
  return coc#status() . get(b:,'coc_current_function','')
endfunction

" Remap for rename current word
nmap <leader>r <Plug>(coc-rename)
" Format
nmap <leader><leader>f :Format<cr>

" Coc error text
" highlight CocErrorSign ctermfg=9 guifg=#fb4934 " Gruvbox
highlight CocErrorSign ctermfg=9 guifg=#ec5f67 " OceanicNext
" }}}


" Cuda stuff {{{
" Highlight keywords from CUDA Runtime API
let g:cuda_runtime_api_highlight = 1

" Highlight keywords from CUDA Driver API
let g:cuda_driver_api_highlight = 1

" Highlight keywords from CUDA Thrust library
let g:cuda_thrust_highlight = 1

" Disable highlighting of CUDA kernel calls
let g:cuda_no_kernel_highlight = 1
" }}} 

" Sync
nnoremap <leader><leader>s :w<CR>:!./sync.sh<CR>
" Run
nnoremap <leader><leader>r :w<CR>:!./run.sh<CR>

" {{{ Enable CUDA filetype
au BufNewFile,BufRead *.cu set ft=cuda
au BufNewFile,BufRead *.cuh set ft=cuda
" }}}
