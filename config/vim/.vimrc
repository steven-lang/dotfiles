set hidden

" Remove '-- INSERT --' line since it is shown in lighline anyway
set noshowmode
set clipboard=unnamed


" Reload .vimrc on save
autocmd! bufwritepost .vimrc source %

" Disable arrows
let g:elite_mode=1

" Enable hard time using hjkl
"let g:hardtime_default_on = 1


" Autoinstall Plug if not available
if empty(glob('~/.vim/autoload/plug.vim'))
  silent execute "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Vim session handling made easy
Plug 'thaerkh/vim-workspace'

" Python/Braceless language text objects
Plug 'tweekmonster/braceless.vim'

Plug 'Yggdroot/indentLine'

"" Autocomplete framework
" Deoplete
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'davidhalter/jedi-vim'
Plug 'zchee/deoplete-jedi'


" Markdown support
Plug 'shime/vim-livedown' " needs livedown: $ npm install -g livedown
Plug 'tpope/vim-markdown'

Plug 'ervandew/supertab'

" Extract with <leader>ev
Plug 'fvictorio/vim-extract-variable'
Plug 'morhetz/gruvbox'

Plug 'terryma/vim-multiple-cursors'

" Python autoimport
Plug 'mgedmin/python-imports.vim'

" Tex
Plug 'lervag/vimtex'

" Have a hard time using hjkl
Plug 'takac/vim-hardtime'

" Easier vim navigation
Plug 'easymotion/vim-easymotion'

" Quoting/paranthesizing made simple
Plug 'tpope/vim-surround'

" Vim git integration
Plug 'tpope/vim-fugitive' " Git commands
Plug 'tpope/vim-rhubarb' " Gbrowse support for github
Plug 'shumphrey/fugitive-gitlab.vim' " Gbrowse support for gitlab
Plug 'airblade/vim-gitgutter' " Git info on the sidebar
Plug 'rhysd/committia.vim' " Git commit extension

" Comment/uncomment with gc
Plug 'tpope/vim-commentary'

" Linting
Plug 'w0rp/ale'

" Python virtual envs
Plug 'plytophogy/vim-virtualenv'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Sensible vim config
Plug 'tpope/vim-sensible'

" Bash support
Plug 'vim-scripts/bash-support.vim'

" Tagbar with <F8>
" Plug 'majutsushi/tagbar'

" CTag automation
Plug 'ludovicchabant/vim-gutentags'

" Bracket autocomplete
Plug 'jiangmiao/auto-pairs'

" Advanced syntax highlighting
Plug 'sheerun/vim-polyglot'

" Statusline
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Julia support
Plug 'JuliaEditorSupport/julia-vim'

" File tree with <C-n>
" Plug 'scrooloose/nerdtree'
" Plug 'Xuyuanp/nerdtree-git-plugin'


" Hex color preview
Plug 'lilydjwg/colorizer'

" Language spell/grammer checker, invoke with: :LanguageToolCheck
Plug 'dpelle/vim-LanguageTool'

" UtilSnips
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

" Add repeat support for plugins
Plug 'tpope/vim-repeat'
Plug 'godlygeek/tabular'

" Initialize plugin system
call plug#end()

filetype plugin indent on    " required

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
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_bold=1
" let g:gruvbox_contrast_dark='soft'
colorscheme gruvbox
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

" Map Ctrl-c to esc
" imap <C-c> <Esc>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Custom mappings
nnoremap H ^
nnoremap L $

" Keep visual mode while indenting
vnoremap < <gv
vnoremap > >gv
" }}}


" Lightline {{{
let g:lightline = {
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'relativepath', 'modified' ] ],
      \   'right' : [ ['lineinfo'], ['percent'], ['filetype'], [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ]]
      \ },
      \ 'colorscheme': 'gruvbox',
      \ 'component_function': {
      \   'mode': 'LightlineMode',
      \   'gitbranch' : 'fugitive#head',
      \ }
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }

let g:lightline.component_type = {
      \     'linter_checking': 'left',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'left',
      \ }

let g:lightline.separator = {
      \   'left': '', 'right': ''
      \}
let g:lightline.subseparator = {
      \   'left': '', 'right': '' 
      \}


function! LightlineMode()
  return expand('%:t') ==# '__Tagbar__' ? 'Tagbar':
        \ expand('%:t') ==# 'ControlP' ? 'CtrlP' :
        \ &filetype ==# 'unite' ? 'Unite' :
        \ &filetype ==# 'vimfiler' ? 'VimFiler' :
        \ &filetype ==# 'vimshell' ? 'VimShell' :
        \ lightline#mode()
endfunction
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
" }}}


" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize +2<CR>
  nnoremap <Right> :vertical resize -2<CR>
endif


" Clear search
nnoremap <silent> <CR> :noh<CR><CR>

" Jedi {{{
let g:jedi#rename_command = "<leader>r"
let g:jedi#auto_close_doc = 1
let g:jedi#usages_command = '<Leader>u'
let g:jedi#goto_command = "gd"
" Disable since deoplete is enabled
let g:jedi#auto_initialization = 1
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#smart_auto_mappings = 0
let g:jedi#popup_on_dot = 0
let g:jedi#completions_command = ""
let g:jedi#show_call_signatures = "1"
let g:jedi#show_call_signatures_modes = 'ni'  " ni = also in normal mode
" }}}

" EasyMotion {{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" }}}

" Customize fzf colors to match your color scheme
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Disable trailing spaces warning
let g:python_highlight_space_errors=0

" ALE config {{{
" Ale fixers
let g:ale_fixers = ['black'] 
let g:ale_fix_on_save = 1

" Highlights
let g:ale_set_highlights = 1

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8']
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" Lint always in Normal Mode
let g:ale_lint_on_text_changed = 'normal'
" Lint when leaving Insert Mode but don't lint when in Insert Mode 
let g:ale_lint_on_insert_leave = 1
" }}}

" Disable latex-box from polyglot dependency to make vimtex usable
let g:polyglot_disabled = ['latex', 'markdown']


" Deoplete {{{
set pumheight=8
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_ignore_case = 1
let g:deoplete#enable_smart_case = 1
" Disable autocompletion (using deoplete instead)
let g:jedi#completions_enabled = 0
" set completeopt-=preview
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/bin/python3'
" }}}


" Python bindings {{{
augroup pythonbindings
  autocmd! pythonbindings
  " Refactor with ALE black
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>r :ALEFix black<CR>

  " Python print stuff in selection
  autocmd Filetype python vnoremap <buffer> <silent> <localleader>p yoprint("<ESC>pa:", <ESC>pa)<ESC>

  " Insert debugging with ipdb
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>b :call InsertIPDB()<CR>

  " Python import
  autocmd Filetype python nnoremap <buffer> <silent> <localleader>i     :ImportName<CR>

  autocmd Filetype python nnoremap <buffer> <silent> <localleader>d :call InsertPydocs()<CR>
  " Function to insert python IPDB debug line
  function! InsertIPDB()
    let trace = expand("import ipdb; ipdb.set_trace(context=5)")
    execute "normal O".trace
  endfunction

  function! InsertPydocs()
    let docs = "\"\"\"Description\n\nArgs:\n    param (type): Description.\n\nReturns:\n    type: Description.\n\n\"\"\""
    execute "normal o".docs
  endfunction
augroup end
" }}}

" LanguageTool config {{{
let g:languagetool_jar = '$HOME/Downloads/LanguageTool-4.3/languagetool-commandline.jar'
hi LanguageToolGrammarError  guisp=#b58900 gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=blue term=underline cterm=none
hi LanguageToolSpellingError guisp=#dc322f  gui=undercurl guifg=NONE guibg=NONE ctermfg=white ctermbg=red  term=underline cterm=none
" }}}

" UtilSnips {{{
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:ultisnips_python_style="google"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
" }}}

" Supertab {{{
let g:SuperTabDefaultCompletionType = "<c-n>"
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

" Leader mappings {{
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
nnoremap <silent> <Leader>t :BTags<CR>
nnoremap <silent> <Leader>T :Tags<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>h :History<CR>
nnoremap <silent> <Leader><Tab> :b#<CR>

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
" " Move to line
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
map <Leader>l <Plug>(easymotion-bd-jk)
" }}


" Vim workspace {{{
nnoremap <leader>s :ToggleWorkspace<CR>
let g:workspace_session_directory = $HOME . '/.vim/sessions/'
let g:workspace_autosave = 0
let g:workspace_autosave_untrailspaces = 0
" }}}

" Vim markdown{{{
let g:vim_markdown_folding_disabled = 1
" }}}

" Unmap malicious plugin bindings
let g:colorizer_nomap = 1
