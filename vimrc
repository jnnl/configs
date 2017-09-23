" vimrc
" jnnl.net

" Plugins
call plug#begin()
Plug 'jnnl/tantalum.vim'
Plug '~/code/git/vim-gatling'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all --no-update-rc' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/seoul256.vim'
Plug 'junegunn/vim-slash'

Plug 'ajh17/vimcompletesme'
Plug 'michaeljsmith/vim-indent-object'
Plug 'ludovicchabant/vim-gutentags'
let g:gutentags_ctags_exclude = ['.git', 'node_modules', 'vendor', 'venv']

Plug 'justinmk/vim-sneak'
let g:sneak#label = 1
let g:sneak#s_next = 1
let g:sneak#use_ic_scs = 1
call plug#end()

" General
set encoding=utf-8
set backspace=indent,eol,start
set hidden
set noshowcmd
set wildmenu
set display+=lastline
set noswapfile

set ttimeout
set ttimeoutlen=10

" Performance tweaks
set synmaxcol=500
set lazyredraw

if has('vim')
    set ttyfast
    set ttyscroll=3
endif

" Statusline
set laststatus=2
set statusline=%f\ %{empty(&ft)?'':'['.&ft.']'}%m%=%l/%L

" Indentation
set autoindent
set expandtab
set smarttab

" Splits
set splitright
set splitbelow

" Search
set incsearch
set ignorecase
set smartcase

" Styles
set number
try | colorscheme tomorrow-night | catch | endtry

" Mappings
map , <leader>

nnoremap § :w<CR>
nnoremap ö <C-o>
nnoremap ä <C-i>
nnoremap Ö g;
nnoremap Ä g,
nnoremap j gj
nnoremap k gk
nnoremap ZA :xa<CR>

nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>t <C-]>

nnoremap <leader>d :Dispatch<CR>
nnoremap <leader>, :Files<CR>
nnoremap <leader>. :Buffers<CR>
nnoremap <leader>- :Ag<CR>
nnoremap <leader>fa :Ag<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fc :Commits<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fl :Lines<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fw :Windows<CR>

" Commands
command! W :exec ':silent w !sudo /usr/bin/tee > /dev/null '
    \ . fnameescape(expand('%:p')) | :e!
command! StripTrailingWhitespace :%s/\s\+$//e
command! StripANSI :%s/\%x1b\[[0-9;]*[a-zA-Z]//ge
command! MatchNonASCII /[^\x00-\x7f]
command! MatchSpecial /FIXME\|TODO\|XXX

" Autocmds
augroup misc
    au!
    au BufWritePre,FileWritePre * :call s:AutoMkDir()
    au GUIEnter * :call s:ApplyGUISettings()
    au FileType vim setlocal keywordprg=:help
    au FileType help setlocal keywordprg=:help
    au FileType make setlocal noexpandtab
augroup END

augroup dispatch
    au!
    au FileType c      let b:dispatch = 'gcc -o "%:p:h" "%:p"'
    au FileType cpp    let b:dispatch = 'g++ -o "%:p:h" "%:p"'
    au FileType python let b:dispatch = 'python3 "%:p"'
    au FileType ruby   let b:dispatch = 'ruby "%:p"'
    au FileType rust   let b:dispatch = 'rustc -o "%:p:h" "%:p"'
    au FileType sh     let b:dispatch = '"%:p"'
augroup END

" Functions
func! s:AutoMkDir()
    let dir = expand('<afile>:p:h')
    if !isdirectory(dir)
        call mkdir(dir, 'p')
    endif
endf

func! s:ApplyGUISettings()
    if has('gui_running')
        if filereadable(expand('~/.gvimrc'))
            source expand('~/.gvimrc')
        else
            set go-=T
            set go-=r
            set go-=L
            set vb
            set t_vb=
            set guifont=Source\ Code\ Pro:h14,Inconsolata:h14
        endif
    endif
endf
