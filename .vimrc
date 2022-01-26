"Author: Guillermo Siliceo Trueba



" BASIC CONFIG

let $VIMRUNTIME='/Users/grillermo/.vim' 
" 
" Disable default color scheme
let macvim_skip_colorscheme=1
" No wrap"
set nowrap
"Vim not vi
set nocompatible "commented because xml.vim folding wont work with it
" show line number
set number
" color our sintax
syntax on
" each enter will shit how much spaces
set shiftwidth=4
" annoying swap message off
set noswapfile
" file recognition
filetype plugin indent on
" Backspace the way it works in every editor
set backspace=indent,eol,start
" Show me mode changes, visual feedback.
set showmode
" Show me what am i typing"
set showcmd
"Remapping the ; to : to save the pinky"
nore ; :
" set ttyfast " tell vim we're using a fast terminal for redraws, redraw only when we need to.
set lazyredraw 
" Ignore case when searching and stuff
set ignorecase
" Long memory
set history=1000
" show the cursor position all the time
set ruler
" keep 3 lines when scrolling
set scrolloff=3 
" don't jump to first character when paging
set nostartofline 
" show title in console title bar
set title 
" Set 7 lines to the curors - when moving vertical..
set so=7 
" size of command line
set cmdheight=2  
"Show matching bracets when text indicator is over them
set showmatch "# 
"none of these are word dividers
set iskeyword+=_,$,@,%,# 
" highlight current cursor position like a pro"
set cursorcolumn 
" Create an market in the column 100
" give me one more character at the end of lines" 
set ve=onemore 
" you can change buffers without saving"
set hidden 
" turn on command line completion wild style for pathx
set wildmenu 
let mapleader = ','
"
" Tab key
"
set ts=4 sw=4 et
set softtabstop=4
" conver tabs to spaces
set expandtab
" tabs mean 4 spaces
set tabstop=4
"
" UI
"
" Hide toolbar icons
set guioptions-=T
" hide tab names
set showtabline=0
" viminfo configuration
set viminfo='1000,f1,\"500,:1000,%,n~/.viminfo
" less verbose messages
set shortmess=atIA
" default the statusline to green when entering Vim
hi statusline guibg=green
" have a permanent statusline to color
set laststatus=2
" End of line column
set cc=100
"
" Search 
"
" search while typing:
set incsearch     
" highlight search results:
set hlsearch      
" restart search from top when bottom hit
set wrapscan      
" case sensitive search when searching with upperase letters
set smartcase     
" ^ and $ are special symbols
set magic         
"
" Folds
"
" Fold with syntax for a smarter folding
set foldmethod=syntax
" everything folded at start
set foldlevelstart=2
"
" Undo
"
" Persisten undo
set undofile
" location
set undodir=~/.vim/undodir
" maximum number of changes that can be undone
set undolevels=1000 
"maximum number lines to save for undo on a buffer reload
set undoreload=1000 
"
" Performace
" 
set nocursorline
set norelativenumber
" Old regex engine because rb syntax highliting is slow with new
set re=1
" Ensure vim does not spit an error on some ymls with base64 stuff
set maxmempattern=2000000
" Dark mode
set bg=dark
" Yank to clipboard
set clipboard=unnamed

" Autocommands

" Save on losing focus, GUI option only
:au FocusLost * silent! wa!
" Save when changing buffer
:au BufLeave * silent! wa!
" * Search Automatically add shebang line
augroup Shebang
  autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl># encoding: UTF-8\<nl>\"|$
augroup END
" Add a horizontal scrollbar
set go+=b
" Indentation for python files
autocmd BufNewFile,BufRead *.py set shiftwidth=4
autocmd BufNewFile,BufRead *.py set tabstop=4
autocmd BufNewFile,BufRead *.py set softtabstop=4
autocmd BufNewFile,BufRead *.py set shiftwidth=4
" Indentation for ruby files
autocmd BufNewFile,BufRead *.ruby set ts=2 sw=2 et
autocmd BufNewFile,BufRead *.ruby set shiftwidth=2
autocmd BufNewFile,BufRead *.ruby set tabstop=2
autocmd BufNewFile,BufRead *.ruby set softtabstop=2
autocmd BufNewFile,BufRead *.rb set shiftwidth=2
autocmd BufNewFile,BufRead *.rb set tabstop=2
autocmd BufNewFile,BufRead *.rb set softtabstop=2
" Indentation for sass files
autocmd BufNewFile,BufRead *.sass set ts=2 sw=2 et
autocmd BufNewFile,BufRead *.sass set shiftwidth=2
autocmd BufNewFile,BufRead *.sass set tabstop=2
autocmd BufNewFile,BufRead *.sass set softtabstop=2
" Indentation for yamls files
autocmd BufNewFile,BufRead *.yml set ts=2 sw=2 et
autocmd BufNewFile,BufRead *.yml set shiftwidth=2
autocmd BufNewFile,BufRead *.yml set tabstop=2
autocmd BufNewFile,BufRead *.yml set softtabstop=2
" Indentation for hamls files
autocmd BufNewFile,BufRead *.haml set ts=2 sw=2 et
autocmd BufNewFile,BufRead *.haml set shiftwidth=2
autocmd BufNewFile,BufRead *.haml set tabstop=2
autocmd BufNewFile,BufRead *.haml set softtabstop=2
" Indentation for erb files
autocmd BufNewFile,BufRead *.erb set ts=4 sw=4 et
autocmd BufNewFile,BufRead *.erb set shiftwidth=4
autocmd BufNewFile,BufRead *.erb set tabstop=4
autocmd BufNewFile,BufRead *.erb set softtabstop=4
" Create directory path when adding a new file if it does not exists
if has("autocmd")
  autocmd BufWritePre * :silent! call mkdir(expand('%:p:h'), 'p')
end


" PLUGINS
"
" Vundle
"
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
" Support libraries
Plugin 'vim-scripts/L9'
Plugin 'xolox/vim-misc'
Plugin 'inkarkat/vim-ingo-library'
" Self explanatory
Plugin 'AndrewRadev/splitjoin.vim'
Plugin 'Shougo/neomru.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'jgdavey/vim-blockle'
Plugin 'lmeijvogel/vim-yaml-helper'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'joukevandermaas/vim-ember-hbs'
Plugin 'mxw/vim-jsx'
Plugin 'ntk148v/vim-horizon'
Plugin 'othree/yajs.vim'
Plugin 'Shougo/unite.vim'
Plugin 'Quramy/vison'
Plugin 'prettier/vim-prettier'
Plugin 'ruanyl/vim-fixmyjs'
Plugin 'AndrewRadev/switch.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'inkarkat/vim-DeleteTrailingWhitespace'
Plugin 'yssl/QFEnter'
Plugin 'tmhedberg/SimpylFold'
Plugin 'rking/ag.vim'
Plugin 'kien/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'sjl/gundo.vim'
Plugin 'preservim/nerdtree'
Plugin 'xuyuanp/git-nerdtree'
Plugin 'vim-syntastic/syntastic'
Plugin 'junegunn/vim-easy-align'
Plugin 'easymotion/vim-easymotion'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tpope/vim-repeat'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-surround'
Plugin 'wakatime/vim-wakatime'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'tmhedberg/matchit'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-commentary'
Plugin 'farmergreg/vim-lastplace'
Plugin 'lukaszb/vim-web-indent'
Plugin 'grillermo/vim-iterm-rspec'
Plugin 'dkprice/vim-easygrep'
Plugin 'tpope/vim-unimpaired'
Plugin 'lilydjwg/colorizer'
Plugin 'jreybert/vimagit'
Plugin 'stefandtw/quickfix-reflector.vim'
" Syntax highlighting
Plugin 'figitaki/vim-dune'
" Additional objects
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'kana/vim-textobj-user'
Plugin 'rhysd/vim-textobj-ruby'
" Color schemes
Plugin 'morhetz/gruvbox'

call vundle#end()
"
" Split join
"
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
let g:splitjoin_ruby_curly_braces=0
let g:splitjoin_quiet=1
let g:splitjoin_ruby_hanging_args=0
let g:splitjoin_ruby_options_as_arguments=1
nmap <Leader>V :SplitjoinJoin<cr>
nmap <Leader>v :SplitjoinSplit<cr>
"
" Ctags
"
set tags+=gems.tags,./tags,tags
"
" Syntastic
"
" Eslint
let g:syntastic_javascript_checkers = ['eslint'] 
let g:syntastic_python_checkers=['flake8']
"
" CTRL P + ag silver searcher
"
let g:ctrlp_working_path_mode = 0
if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  set grepprg=ag\ --nogroup\ --nocolor
  
  " " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif
"
" RSpec.vim 
"
map <Leader>rf :w<CR>:RunItermSpringSpec<CR>
map <Leader>rc :w<CR>:RunItermSpringSpecLine<CR>
let g:rspec_runner = "os_x_iterm"
"
" NERDTREE
"
" Toggle show hidden files for NERDTREE
let NERDTreeShowHidden=1
" Fix lag while browsing
let NERDTreeHighlightCursorline=0
let NERDTreeQuitOnOpen=0
let NERDTreeAutoDeleteBuffer=1
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeWinSize=60
"
" Vim switch
"
map <Leader>s :Switch<CR>
let g:switch_custom_definitions =
    \   [
    \     {
    \       '\<\(\k\+\): ':  '''\1'' => ',
    \     }
    \   ]
"
" HTML Tidy
"
" select xml text to format and hit ,x
vmap <leader>h :!tidy -q -i -xml --force-output 1 --char-encoding utf8<CR>
nore <leader>h :!tidy -q -i -xml --force-output 1 --char-encoding utf8<CR>
"
" EasyGrep
"
let g:EasyGrepRecursive=1
" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>
"
" Vim Indent
"
let g:indent_guides_start_level=2
let g:indent_guides_guide_size = 1
"
" Jquery underscore syntax
"
autocmd BufReadPre *.js let b:javascript_lib_use_jquery = 1
autocmd BufReadPre *.js let b:javascript_lib_use_underscore = 1
"
" EASY align
"
vmap <leader><SPACE> <Plug>(EasyAlign)
"
" Prettier
"
vmap <leader>p :Prettier<CR>
"
" UNITE
"
nnoremap <leader>u :Unite<CR>
nnoremap <leader>m :Unite file_mru <CR> 
nnoremap <leader>l :Unite line<CR> 
function! s:unite_settings()
    " Enable navigation with control-j and control-k in insert mode
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
endfunction
" Custom mappings for the unite buffer
autocmd! FileType unite call s:unite_settings()
let g:unite_enable_start_insert = 1
let g:unite_winheight = 20
" Match fuzzy finder ctrlp like'
call unite#filters#matcher_default#use(['matcher_fuzzy'])
"
" GUndo 
"
if has('python3')
    let g:gundo_prefer_python3 = 1
endif
map <leader>g :GundoToggle<cr>
map <C-g> :GundoToggle<cr>
"
" Airline
"
let g:airline_section_a = ''
let g:airline_section_b = ''
let g:airline_section_y = ''
let g:airline_section_x = ''
let g:airline_section_z = ''
"
" Coc
"
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
let g:coc_disable_startup_warning = 1
" 
" Copy YAML paths
"
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cy :YamlGetFullPath<CR>
endif
"
" Gruvbox
"
colorscheme gruvbox



" Defaults fixes and custom personal mappins shortcuts and hotkeys

" Do not force me to do "0p after overriding something with paste
xnoremap p "_dP
" Disable middle click wheel to paste
noremap <MiddleMouse> <LeftMouse>
" " Make backspace work in normal mode
nmap <Backspace> d<Left>
" Scroll faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>
" Quickfix movement
nmap <leader>qn :cnext<cr>
nmap <leader>qp :cprevious<cr>
" browse through windows
nmap <Tab> <C-w>w
nmap <s-Tab> <C-w>W
" " Quickly add a return in normal mode
noremap <cr> o <Backspace><Esc>
" Restore behavior in quickfix
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>
" Indent with tabs in visual mode"
vmap <Tab> >gv
vmap <S-Tab> <gv
" Move between buffers using tabs
map <C-Tab> :bnext<cr>
map <C-S-Tab> :bcrevious<cr>
" Move between buffers with home keys
map ∆ <C-w>j 
map ˚ <C-w>k 
map ¬ <C-w>l 
map ˙ <C-w>h
" Move text around with ctrl and hjkl
nmap <C-l> >>
nmap <C-h> <<
" Yank cut
nmap <C-X> Ydd
" Close the window and delete the buffer associated with it
map <D-q> :bd!<cr>
" Fix shift-v selecting all the line including the endofline
nmap <S-v> g^v$
" Mapping shift tab to <s-tab>
map <Esc>[Z <s-tab>
ounmap <Esc>[Z
"remap save
map <D-s> :update!<cr>
map <C-s> :update!<cr>
"remap copy
map <D-c> <c-c>
map <D-v> <c-v>
imap <D-v> <c-v>
" i don't want the end of the line to be selected
vnoremap $ $<left>
" the standard w behavior sucks i like more how e works
vmap w e
" Disable ex mode
map Q <Nop>
" Set foldlevel
map <leader>f1 :set foldlevel=1<CR>
map <leader>f2 :set foldlevel=2<CR>
map <leader>f3 :set foldlevel=3<CR>
map <leader>f4 :set foldlevel=4<CR>
map <leader>f5 :set foldlevel=5<CR>
"Move cursor as expected with wrapped lines"
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
" Do not jump immediatly with *
nmap <silent> * "syiw<Esc>: let @/ = @s<CR>
nmap ,cs :let @*=expand("%")<CR>
nmap ,cl :let @*=expand("%:p")<CR>
" Run ruby file
nnoremap <leader>r :!ruby % <CR> 
" When \ is pressed, Vim waits for our input:
nnoremap \ :Ag! -Q<SPACE>
" Insert mode move, useful in quickfix and searches 
imap <C-l> <right>
imap <C-k> <up>
imap <C-j> <down>
imap <C-h> <left>
" Copy current file to clipboard without losing position
map <leader>ca :%y+<CR>
"
map <leader><F2> :ColorToggle<CR>
"
" Spelling mistakes
"
iab pry binding.pry


" Functions

function MyNerdToggle()
    if &filetype == 'nerdtree'
        :NERDTreeToggle
    elseif bufname('%') == ''
        :NERDTreeToggle
      elseif exists("g:NERDTree") && g:NERDTree.IsOpen()
        :NERDTreeToggle
      else
        :NERDTreeFind
    endif
endfunction
nnoremap <C-n> :call MyNerdToggle()<CR>

" Copy current ruby file including requires into clipboard
function! CopyCurrentRubyFile()
  !ruby /Users/grillermo/c/aliada/devops-scripts/utils/copy_to_clipboard.rb %
endfunction
nnoremap <leader>cr :call CopyCurrentRubyFile()<CR> <CR>

" Copy current working file paths
if has("mac") || has("gui_macvim") || has("gui_mac")
  " relative path  (src/foo.txt)
  nnoremap <leader>cf :let @*=expand("%")<CR>

  " absolute path  (/something/src/foo.txt)
  nnoremap <leader>cF :let @*=expand("%:p")<CR>
endif

" Mass indentation config
function! Indent4spaces()
    echo "Indenting with 4 spaces"
    set shiftwidth=4
    set tabstop=4
    set softtabstop=4
    set shiftwidth=4
endfunction
function! Indent2spaces()
    echo "Indenting with 2 spaces"
    set shiftwidth=2
    set tabstop=2
    set softtabstop=2
    set shiftwidth=2
endfunction
nmap <leader>i4 :call Indent4spaces()<CR>
nmap <leader>i2 :call Indent2spaces()<CR>

" Move lines with arrow keys
function! MoveLineUp()
  call MoveLineOrVisualUp(".", "")
endfunction
function! MoveLineDown()
  call MoveLineOrVisualDown(".", "")
endfunction
function! MoveVisualUp()
  call MoveLineOrVisualUp("'<", "'<,'>")
  normal gv
endfunction
function! MoveVisualDown()
  call MoveLineOrVisualDown("'>", "'<,'>")
  normal gv
endfunction
function! MoveLineOrVisualUp(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num - v:count1 - 1 < 0
    let move_arg = "0"
  else
    let move_arg = a:line_getter." -".(v:count1 + 1)
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction
function! MoveLineOrVisualDown(line_getter, range)
  let l_num = line(a:line_getter)
  if l_num + v:count1 > line("$")
    let move_arg = "$"
  else
    let move_arg = a:line_getter." +".v:count1
  endif
  call MoveLineOrVisualUpOrDown(a:range."move ".move_arg)
endfunction
function! MoveLineOrVisualUpOrDown(move_arg)
  let col_num = virtcol(".")
  execute "silent! ".a:move_arg
  execute "normal! ".col_num."|"
endfunction
nnoremap <silent> <C-k> :<C-u>call MoveLineUp()<CR>
nnoremap <silent> <C-j> :<C-u>call MoveLineDown()<CR>
