" Sections:
"    -> General
"    -> VIM user interface
"    -> Colors and Fonts
"    -> Files and backups
"    -> Text, tab and indent related
"    -> Visual mode related
"    -> Moving around, tabs and buffers
"    -> Status line
"    -> Editing mappings
"    -> vimgrep searching and cope displaying
"    -> Spell checking
"    -> Misc
"    -> Helper functions
"    -> Plugin settings
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VimPlug init (do not touch)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
source ~/.vim/plugsettings.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Enhance compatibility for Fish users
if &shell =~# 'fish$'
    set shell=sh
endif

" Sets how many lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

""" Custom Filtypes:
au BufNewFile,BufEnter,BufRead,BufWritePost *.dotinfo    setf json
au BufNewFile,BufEnter,BufRead,BufWritePost *.rasi       setf css

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>
nmap <leader>W :w!<cr>

" :W sudo saves the file
" (useful for handling the permission-denied error)
if has('nvim')
    command W exe 'w !sudo tee > /dev/null %:p:S' | setl nomod
else
    command W w !sudo tee > /dev/null %
endif

" Enable mouse support in all modes
if has('nvim')
    set mouse=a
endif

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Show relative line count
" Switch back to absolute when loosing focus
set number
set relativenumber

" Set 7 lines to the cursor - when moving vertically using j/k
set so=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler
set rulerformat=%l,%c%V%=%P

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
" set noerrorbells
" set novisualbell
" set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Display what you can fold if folding is enabled
if &fdm != "manual"
    set foldcolumn=1
endif

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Enable syntax highlighting
syntax enable

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Chose a theme depending on wether you're using term or TTY
if &term == "linux"
    source ~/.vim/plugged/jellybeans.vim/colors/jellybeans.vim
    let g:jellybeans_overrides = {
                \'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
                \}
    let g:jellybeans_use_term_italics = 1
    let g:jellybeans_use_lowcolor_black = 1
else
    source ~/.vim/plugged/Gummybears/colors/gummybears.vim
    " Disable text having a different BG from empty lines
    hi Normal ctermbg=0
    hi LineNr ctermfg=DarkGrey
    hi! link SignColumn Normal
endif

" Higlight characters that exceed a certain columns limit
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
" C/C++:
autocmd BufEnter,FileType *.c,*.cpp,*.h,*.hpp match OverLength /\%>79v.\+/
" Makefiles
autocmd BufEnter,FileType Makefile,makefile,*.mk,*.mak match OverLength /\%>124v.\+/

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close current buffer
map <C-W>b :Bclose<cr>

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Move between buffers
map <S-PageUp> :bprevious<cr>
map <S-PageDown> :bnext<cr>
imap <S-PageUp> <Esc>:bprevious<cr>
imap <S-PageDown> <Esc>:bnext<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Never show the status line (plugins do better)
set laststatus=0

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-Up> mz:m-2<cr>`z
nmap <M-Down> mz:m+<cr>`z
vmap <M-Up> :m'<-2<cr>`>my`<mzgv`yo`z
vmap <M-Down> :m'>+<cr>`<my`>mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing whitespaces on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

    " Some filetypes NEED trailing whitespaces, like in Markdown to
    " explicitly tell the parser to add a linebreak with two trailing spaces.
    let g:CleanExtraSpaces_exclude = ['markdown', 'md']

    " The condition needs to be IN the autocmd.
    " If the autocmd is defined from inside and if block with this condition,
    " it won't work as apparently the filetype is set AFTER sourcing the
    " configuration file.
    autocmd BufWritePre *
        \ if index(CleanExtraSpaces_exclude, &filetype) == -1
        \ |  :call CleanExtraSpaces()
        \ | endif

" Sort selection
vmap <M-s> :sort<cr>

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
" map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
" map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

" Allow cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Automatically find python 2 & 3 providers for NeoVim
if has('nvim')
    let g:python_host_prog = system('which python2 | tr -d "\n"')
    let g:python3_host_prog = system('which python3 | tr -d "\n"')
endif

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"}}}
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{

" Airline: automatically display all buffers when only one tab is open
let g:airline#extensions#tabline#enabled = 1

" Airline: Show Gutentags' status
" let g:airline#extensions#gutentags#enabled = 1

" Airline: tail formatter
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Airline: Show Airline on top
" let g:airline_statusline_ontop=1

" Airline: theme
let g:airline_theme='simple'

" CLang Format: integration in Normal and Visual mode
let g:clang_format#detect_style_file=1
autocmd FileType c,cpp,objc nnoremap <buffer><C-K> :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><C-K> :ClangFormat<CR>

" CoC Formatter: Press F10 to use CoC's :Format command in NeoVim
if has('nvim')
    noremap <F10> :Format<CR>
endif

" NERDTree: shortcut
map <C-n> :NERDTreeToggle<cr>

" NERDTree: Close vim when the only window left open is NerdTree
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTree: Open NerdTree when opening a directory or without arguments
" Make sure to no open NERDTree when you're sending something on (N)Vim"s standard input
autocmd StdinReadPre * let s:std_in=1
if (argc() == 0)
    " No argumet                    Comment to deactivate
    autocmd VimEnter * exe 'NERDTree' getcwd() | wincmd p | exe 'cd '.getcwd()
elseif (argc() == 1 && isdirectory(argv(0)) && !exists("s:std_in"))
    " Single argument (directory)   Comment to deactivate
    autocmd VimEnter * exe 'NERDTree' argv(0) | wincmd p | ene | exe 'cd '.argv(0)
endif

" NERDTree: File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
    exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Gutentags: Status bar
" set statusline+=%{gutentags#statusline()}

" Tagbar: Toggle
nmap <F8> :TagbarToggle<CR>

" Templates: C project name detection
function! GetCProjectName()
     return system("pwd | grep -q libfox && echo -n 'Libfox' || make -np NOLIBFOX=1 2>/dev/null | grep -E '^NAME' | perl -pe 's/(( |\t)*NAME( |\t)*[:+?]?=( |\t)*|(\n|\r)*)//g' 2>/dev/null")
endfunction
let g:templates_user_variables = [
            \   ['CPROJNAME', 'GetCProjectName'],
            \ ]

" Switch Buffer: Just a keymap
nnoremap S :SwitchBuffer <cr>

" Templates: My templates dir
let g:templates_directory = ['~/.vim/my_templates']

" Vim Goto Header: Press F12 at any time when on a header's include line to go to it
if ! has('nvim')
    nnoremap <F12> :GotoHeader <CR>
    imap <F12> <Esc>:GotoHeader <CR>
endif

" Script Runner: Set custom hotkey
let g:script_runner_key = '<F12>'

"}}}

" This line ensures folding occurs where markers {{{ ... }}} are set.
" vim: fdm=marker
