set t_Co=256
set bg=light
"colo desert  " constants become brown / orange, not red
" colo pablo  " too faded
"colo slate
colo zellner

filetype plugin on
set statusline=[%n]\ %<%F\ \ \ [%M%R%H%W%Y][%{&ff}]\ @%{strftime(\"%H:%M:%S\")}\ \ %=\ line:%l/%L\ col:%c\ \ \ %p%%
set tw=75
set hlsearch
set incsearch
set ai
set si
set showcmd
set showmode
set wildmenu
set laststatus=2
set number
"set backup
"set backupdir='~/.vim/'
set cmdwinheight=3


"
"""" NERDTree
"
"let g:NERDTreeWinSize = 20
"CommandMap [Prefix]t     NERDTree
"CommandMap [Prefix]T     NERDTreeClose
"CommandMap [Prefix]<C-t> execute 'NERDTree' expand('%:p:h')
"Arpeggionmap <silent> nt :<C-u>NERDTreeToggle</CR>
"



"
"  statusline (vanilla)
"
" now set it up to change the status line based on mode
"if version >= 700
"   au InsertEnter * hi StatusLine ctermfg=blue ctermbg=yellow
"   au InsertLeave * hi StatusLine ctermfg=yellow ctermfg=blue
"endif
"hi statusline term=bold ctermfg=blue ctermbg=yellow guifg=#0000FF guibg=#FFFF00
hi CursorLine term=bold cterm=bold ctermbg=233 guibg=gray20 guifg=bold
set cursorline


"
"  powerline
"
"
let g:Powerline = 'fancy'
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
