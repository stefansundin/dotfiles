" sudo cp .vimrc /root/
" Set vim as default editor:
" sudo update-alternatives --set editor /usr/bin/vim.basic
" Or: "sudo update-alternatives --config editor" and select vim.basic (which is normal vim)
" vim .bashrc
" sudo vim /root/.bashrc
" export EDITOR=vim
" export VISUAL=vim

" Remove Ubuntu 17.04+ behavior of remembering file positions
" See /usr/share/vim/vim80/defaults.vim
:augroup vimStartup | au! | augroup END

" Use ':set paste' to disable indenting when pasting blocks of code
" Use ':set nopaste' when done
" Show tabs:
" :set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" :set list

" Convert dos to unix (removes ^M)
" :update
" :e ++ff=dos
" :setlocal ff=unix
" :w


set smartindent
"set nowritebackup
"set mousehide

" Enable mouse support
set mouse=a
" Make mouse work when PuTTY terminal string is 'linux' (in Connection -> Data)
set ttymouse=xterm2
" Tab to 4 spaces
set tabstop=4

" Key mappings
" Find out what escape sequence a key has by pressing Ctrl+V, then the key
" You must replace the ^[ sequences below this way

" Fix Home/End when using xterm and default PuTTY
map ^[Ow <Home>
map ^[Oq <End>
imap ^[Ow <Home>
imap ^[Oq <End>

" Mac delete key
map ^D <Del>
imap ^D <Del>

" Mac Alt+Left/Right
map ^[b <S-Left>
imap ^[b <S-Left>
map ^[f <S-Right>
imap ^[f <S-Right>

" Ctrl+S to save
" You must edit .bashrc too, and add this:
" # Disable XOFF (Ctrl+S in PuTTY, XON is Ctrl+Q)
" stty ixany
" stty ixoff -ixon
" stty stop undef
" stty start undef
map <C-s> :w<cr>
imap <C-s> <ESC>:w<cr>a

" Ctrl+Q to quit, hold shift to discard changes
map <C-q> :q<cr>
imap <C-q> <ESC>:q<cr>
map <C-S-q> :q!<cr>
imap <C-S-q> <ESC>:q!<cr>

" Ctrl+Z to undo
" Use Ctrl+R to redo
map <C-z> u
imap <C-z> <ESC>u<cr>
