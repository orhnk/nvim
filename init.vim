let mapleader=" "
set number
set rnu
set termguicolors
set fillchars+=eob:\ 
" set softtabstop
set tabstop=3
set shiftwidth=3
syntax on

" Highlight current cursorline
augroup CursorLine
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
augroup END

" Make line numbers italic
augroup LineNumbers
    autocmd!
    autocmd VimEnter,WinEnter,BufWinEnter * highlight LineNr cterm=italic gui=italic
    autocmd WinLeave * highlight LineNr cterm=NONE gui=NONE
augroup END

set undodir=~/.vim/undodir
set undofile

augroup CursorLine
	autocmd!
	autocmd VimEnter,WinEnter,BufWinEnter * highlight CursorLineNr gui=bold,italic
augroup END

" set hls
set cursorline
set cursorlineopt=number

filetype plugin on

call plug#begin("/home/kobruh/.vim/plugged/")
" Plug 'lambdalisue/fern.vim'
Plug 'rhysd/vim-clang-format'

" Colorschemes
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'romgrk/doom-one.vim' " Emacs doom default theme
Plug 'dracula/vim'
Plug 'altercation/solarized'
Plug 'tomasr/molokai'
Plug 'sonph/onehalf'
" Plug 'nurmine/Zenburn' " Errorneus
Plug 'gosukiwi/vim-atom-dark'
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'sjl/badwolf/'
Plug 'nordtheme/vim'
Plug 'nanotech/jellybeans.vim'
Plug 'sindresorhus/hyper-snazzy'
Plug 'rakr/vim-one'
Plug 'mhartington/oceanic-next'
Plug 'ayu-theme/ayu-vim'
Plug 'ciaranm/inkpot'
Plug 'kyoz/purify'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'sainnhe/gruvbox-material'
Plug 'sainnhe/everforest'
Plug 'sainnhe/sonokai'
Plug 'sainnhe/edge'

" COMMENTER
Plug 'preservim/nerdcommenter'

" Git
" Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-signify'

" File Explorer
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'

" Surrounding Editing (e.g. change quotes, brackets, etc.)
Plug 'tpope/vim-surround'
"-----> cs<first char><second char> ;to change surrounding <First Char> with <Second Char>

" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'agude/vim-eldar'
"Plug 'EdenEast/nightfox.nvim'
"Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/remote', 'do': ':UpdateRemotePlugins' }
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim' " needed for previews
"Plug 'yuki-yano/fzf-preview.vim', { 'branch': 'release/rpc' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Chiel92/vim-autoformat'
"Plug 'kevinhwang91/rnvimr'  " 文件浏览器

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" CocInstall coc-snippets
" CocInstall coc-rust-analyzer  "Rust"
" CocInstall coc-python  	     "Python"
" CocInstall coc-clangd   		  "C/C++"
" CocInstall coc-hls   			  "Haskell"
" CocInstall coc-toml  			  "TOML"
" CocInstall coc-lua  			  "Lua"
" CocInstall coc-vimlsp			  "Vim"
" CocInstall coc-pairs
" CocInstall coc-prettier

" Haskell development:
Plug 'neovimhaskell/haskell-vim'

" Automatic shebang generation
Plug 'samirettali/shebang.nvim'

" Plug 'honza/vim-snippets'
"Plug 'neoclide/coc-denite'
"Plug 'ayu-theme/ayu-vim'
"Plug 'joshdick/onedark.vim'
"Plug 'dracula/vim', { 'as': 'dracula' }
"Plug 'itchyny/lightline.vim'
"Plug 'Yggdroot/indentLine' " Hate that shit (!) I think that was this one
" Plug 'sheerun/vim-polyglot'
" Plug 'golang/lint'
"Plug 'mg979/vim-xtabline'  " 精致的顶栏
" Plug 'mbbill/undotree'     " Undo Tree
"Plug 'liuchengxu/vista.vim' " 打开函数与变量列表
"Plug 'lambdalisue/suda.vim' " :sudowrite 或者 :sw 就等于sudo vim ...

" Copilot
Plug 'github/copilot.vim'
" |---> Requires: git clone https://github.com/github/copilot.vim.git ~/.config/nvim/pack/github/start/copilot.vim

call plug#end()

"------------------
" VIM KEY BINDINGS |
"-----------------------------------------------
" F2 -> Compile&Run the entire project          |
" F3 -> Execute the current file from extension |
" F4 -> Execute the current file with Shebang   |
"-----------------------------------------------

map <F2> <ESC>:wa<CR>:RunAll<CR>
map <F3> <ESC>:wa<CR>:Run<CR>
map <F4> <ESC>:wa<CR>:!if [ -x /path/to/file.sh ]; then ./%; else chmod +x %; ./%; fi<CR>
noremap! <C-BS> <C-w>
noremap! <C-h> <C-w>

"---------------
" VIM FUNCTIONS |
"--------------------------------------------
" :Run -> compiles & runs the entire project |
"--------------------------------------------

command! -nargs=0 RunAll :call RunAll()
function! RunAll()
    let l:dirname = expand('%:p:h')
    let l:extension = substitute(expand('%:p'), '.*\.', '', '')
    if l:extension ==# 'rs'
        execute '!cd ' . l:dirname . ' && cargo run'
    elseif l:extension ==# 'cpp'
        execute '!cd ' . l:dirname . ' && g++ *.cpp -o output && ./output'
    elseif l:extension ==# 'py'
        execute '!cd ' . l:dirname . ' && python *.py'
    elseif l:extension ==# 'java'
        execute '!cd ' . l:dirname . ' && javac *.java && java ' . substitute(expand('%:t'), '\.java$', '', '')
    elseif l:extension ==# 'c'
        execute '!cd ' . l:dirname . ' && gcc *.c -o output && ./output'
    elseif l:extension ==# 'scala'
        execute '!cd ' . l:dirname . ' && scala ' . expand('%:t')
    elseif l:extension ==# 'swift'
        execute '!cd ' . l:dirname . ' && swiftc *.swift && ./' . substitute(expand('%:t'), '\.swift$', '', '')
    elseif l:extension ==# 'js'
        execute '!cd ' . l:dirname . ' && node *.js'
    elseif l:extension ==# 'php'
        execute '!cd ' . l:dirname . ' && php *.php'
    elseif l:extension ==# 'rb'
        execute '!cd ' . l:dirname . ' && ruby *.rb'
    elseif l:extension ==# 'pl'
        execute '!cd ' . l:dirname . ' && perl *.pl'
    elseif l:extension ==# 'lua'
        execute '!cd ' . l:dirname . ' && lua *.lua'
    elseif l:extension ==# 'go'
        execute '!cd ' . l:dirname . ' && go run *.go'
    elseif l:extension ==# 'sh'
        execute '!cd ' . l:dirname . ' && bash *.sh'
    elseif l:extension ==# 'jl'
        execute '!cd ' . l:dirname . ' && julia *.jl'
    elseif l:extension ==# 'hs'
        execute '!cd ' . l:dirname . ' && runhaskell *.hs'
    elseif l:extension ==# 'kt'
        execute '!cd ' . l:dirname . ' && kotlinc *.kt -include-runtime -d ' . substitute(expand('%:t'), '\.kt$', '.jar', '') . ' && java -jar ' . substitute(expand('%:t'), '\.kt$', '.jar', '')
    elseif l:extension ==# 'clj'
        execute '!cd ' . l:dirname . ' && clojure *.clj'
    elseif l:extension ==# 'cs'
        execute '!cd ' . l:dirname . ' && mcs *.cs && mono ' . substitute(expand('%:t'), '\.cs$', '.exe', '')
    elseif l:extension ==# 'vb'
        execute '!cd ' . l:dirname . ' && vbnc *.vb && mono ' . substitute(expand('%:t'), '\.vb$', '.exe', '')
    elseif l:extension ==# 'ml'
        execute '!cd ' . l:dirname . ' && ocamlc *.ml -o output && ./output'
    elseif l:extension ==# 'pas'
        execute '!cd ' . l:dirname . ' && fpc *.pas && ./' . substitute(expand('%:t'), '\.pas$', '', '')
    elseif l:extension ==# 'r'
        execute '!cd ' . l:dirname . ' && Rscript *.r'
    elseif l:extension ==# 'd'
        execute '!cd ' . l:dirname . ' && dmd *.d && ./' . substitute(expand('%:t'), '\.d$', '', '')
    else
        echo 'Unsupported file extension: ' . l:extension
    endif
endfunction

command! -nargs=0 Run :call Run()
function! Run()
let l:filename = expand('%')
    let l:extension = substitute(l:filename, '.*\.', '', '')
    if l:extension ==# 'rs'
        execute '!rustc ' . l:filename . ' && ./'
    elseif l:extension ==# 'cpp'
        execute '!g++ ' . l:filename . ' -o ' . l:filename . '.out && ./' . l:filename . '.out'
    elseif l:extension ==# 'py'
        execute '!python ' . l:filename
    elseif l:extension ==# 'java'
        execute '!javac ' . l:filename . ' && java ' . substitute(l:filename, '\.java$', '', '')
    elseif l:extension ==# 'c'
        execute '!gcc ' . l:filename . ' -o ' . l:filename . '.out && ./' . l:filename . '.out'
    elseif l:extension ==# 'scala'
        execute '!scala ' . l:filename
    elseif l:extension ==# 'swift'
        execute '!swiftc ' . l:filename . ' && ./' . substitute(l:filename, '\.swift$', '', '')
    elseif l:extension ==# 'js'
        execute '!node ' . l:filename
    elseif l:extension ==# 'php'
        execute '!php ' . l:filename
    elseif l:extension ==# 'rb'
        execute '!ruby ' . l:filename
    elseif l:extension ==# 'pl'
        execute '!perl ' . l:filename
    elseif l:extension ==# 'lua'
        execute '!lua ' . l:filename
    elseif l:extension ==# 'go'
        execute '!go run ' . l:filename
    elseif l:extension ==# 'sh'
        execute '!bash ' . l:filename
    elseif l:extension ==# 'jl'
        execute '!julia ' . l:filename
    elseif l:extension ==# 'hs'
        execute '!runhaskell ' . l:filename
    elseif l:extension ==# 'kt'
        execute '!kotlinc ' . l:filename . ' -include-runtime -d ' . substitute(l:filename, '\.kt$', '.jar', '') . ' && java -jar ' . substitute(l:filename, '\.kt$', '.jar', '')
    elseif l:extension ==# 'clj'
        execute '!clojure ' . l:filename
    elseif l:extension ==# 'cs'
        execute '!mcs ' . l:filename . ' && mono ' . substitute(l:filename, '\.cs$', '.exe', '')
    elseif l:extension ==# 'vb'
        execute '!vbnc ' . l:filename . ' && mono ' . substitute(l:filename, '\.vb$', '.exe', '')
    elseif l:extension ==# 'ml'
        execute '!ocamlc ' . l:filename . ' -o ' . substitute(l:filename, '\.ml$', '', '') . ' && ./' . substitute(l:filename, '\.ml$', '', '')
    elseif l:extension ==# 'pas'
        execute '!fpc ' . l:filename . ' && ./' . substitute(l:filename, '\.pas$', '', '')
    elseif l:extension ==# 'r'
        execute '!Rscript ' . l:filename
    elseif l:extension ==# 'd'
        execute '!dmd ' . l:filename . ' && ./' . substitute(l:filename, '\.d$', '', '')
    elseif l:extension ==# 'scala'
        execute '!scala ' . l:filename
    elseif l:extension ==# 'rs'
        execute '!rustc ' . l:filename . ' && ./'
    else
        echo 'Unsupported file extension: ' . l:extension
    endif
endfunction

"----------------
"   COC-CONFIG   |
"--------------------------------
" C-l -> Go to definition        |
" C-h -> Go back                 |
" :CocInstall coc-snippets	      |
" :CocInstall coc-json	         |
" :CocInstall coc-rust-analyzer  |
" :CocInstall coc-python	      |
" :CocInstall coc-pairs	         |
" :CocInstall coc-clangd	      |
"--------------------------------

inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<TAB>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Coc-snippets

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


"----------------
" NERD COMMENTER |
"-------------------------------------------------------------------
" Use compact syntax for prettified multi-line comments 				  |
" G C Comment out the current line or text selected in visual mode. |
"-------------------------------------------------------------------

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

map gc <Plug>NERDCommenterToggle

"---------------
"    COPILOT    |
"--------------------------------------
" Ctrl+D to select next suggestion	   |
" Ctrl+A to select previous suggestion |
" Ctrl+ESC to dismiss the panel		   |
" Ctrl+S to open the panel		         |
"--------------------------------------

" let b:copilot_enabled = v:true

imap <C-D> <Plug>(copilot-next)
imap <C-A> <Plug>(copilot-previous)
imap <C-ESC> <Plug>(copilot-dismiss)

inoremap <C-S> <Esc>:execute 'Copilot panel'<CR>

"----------------
"    AIRLINE     |
"---------------------------
" :AirlineTheme gruvbox		 |
" Use triangular separators |
"---------------------------

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_close_button = 1

"---------------
"  COLORSCHEME  |
"---------------

colorscheme gruvbox

"----------------
"   NERD TREE    |
"--------------------------------
" C-a to toggle NERDTree	      |
" C-n to open NERDTree	  	 		|
" C-t to toggle NERDTree         |
" C-f to find file in NERDTree   |
" <leader>n to focus NERDTree    |
"--------------------------------

let NERDTreeShowHidden=1
let NERDTreeMinimalUI=1
let NERDTreeShowBookmarks=1
" let NERDTreeShowLineNumbers=1
let NERDTreeWinPos="right"
let NERDTreeWinSize=30
let g:NERDTreeDirArrowExpandable = ' '
let g:NERDTreeDirArrowCollapsible = ' '

" Hide the current working directory in NERDTree
augroup nerdtreehidecwd
	autocmd!
	autocmd FileType nerdtree setlocal conceallevel=3
				\ | syntax match NERDTreeHideCWD #^[</].*$# conceal
				\ | setlocal concealcursor=n
augroup end

map <C-z> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

"----------------
"      FZF       |
"----------------

" Use ripgrep for fzf (Copilot)
let g:fzf_command_prefix = 'rg --files --hidden --follow --glob "!.git/*"'
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.4 } }
let g:fzf_preview_window = 'right:50%'
let g:fzf_preview_file = 'cat {}'
let g:fzf_preview_file = 'bat --style=numbers --color=always {}'


"---------------
"    SHEBANG    |
"---------------

let g:shebang_commands = {	'rs': '/usr/bin/env run-cargo-script',	'c': '/usr/bin/c' } " #!/usr/bin/env run-cargo-script

"--------------
"   TERMINAL   |
"--------------
" :terminal
" :term

set shell=/bin/zsh

"----------------
"     CONFIG     |
"----------------
" :Config "Opens config file"

command Config :e $MYVIMRC

"----------------
"     HASKELL    |
"----------------
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
let g:haskell_classic_highlighting = 1
