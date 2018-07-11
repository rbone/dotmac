" -----------------------------
"     Configure basic vim
" -----------------------------

" enable syntax highlighting
syntax on

" disable modelines as I don't care for them and they can be a security problem
set modelines=0

" ensure vim is not set to needlessly be compatible with vi
set nocompatible


" -----------------------------
"      Configure plugins
" -----------------------------

" --- ctrlp.vim: https://github.com/ctrlpvim/ctrlp.vim ---

let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrl_show_hidden = 1
let g:ctrlp_lazy_update = 1

" configure how many files ctrlp can show at once
let g:ctrlp_max_height = 24

" --- jellybeans.vim: https://github.com/nanotech/jellybeans.vim ---

" use my terminals background colour instead of jellybeans default
let g:jellybeans_overrides = {
\    'background': { 'ctermbg': 'none', '256ctermbg': 'none' },
\}

" turn the theme on. Must be done after any theme config!
colorscheme jellybeans

" --- ack.vim: https://github.com/mileszs/ack.vim ---

" use ag instead of ack
let g:ackprg = 'ag --vimgrep'

" don't open the first result automatically
"cnoreabbrev Ack Ack!

" --- editorconfig.vim: https://github.com/editorconfig/editorconfig-vim ---

" nothing?

" --- go.vim: https://github.com/fatih/vim-go

" disable showing a location list when go fmt fails, it only adds
" clutter and distraction when I already have ale doing linting and
" error checking
let g:go_fmt_fail_silently = 1

" use goimports instead of gofmt for automatically inserting import paths
let g:go_fmt_command = "goimports"

" --- ale.vim

let g:ale_fixers = {
\   'php': ['phpcbf'],
\}

" So I don't need to worry about fixing things myself.
let g:ale_fix_on_save = 1

" use my global one rather than the vendored one as I'm seeing strange
" behaviour in vendored phpcbf
let g:ale_php_phpcbf_use_global=1

" Don't use golint as its pedantry over everything having a comment
" distracts from other issues.
let g:ale_linters = {'go': ['gofmt', 'go vet']}

" Ensure the sign gutter always remains open so the window layout doesn't
" move about constantly when working on a file.
let g:ale_sign_column_always = 1

" -----------------------------
"      Configure misc vim
" -----------------------------

" tells vim to automatically try figuring out how to indent things
set smartindent

" show line numbers by default
set nu

" tells vim to hide buffers instead of attempting to close them when they're no longer visible
set hidden

" use OSX clipboard
set clipboard=unnamed

" disable visual & audio bell
set visualbell
set novb

" show 80 character limit
set colorcolumn=80

" highlight the line with the cursor
" currently disabled as it makes vim scrolling incredibly slow :(
" set cursorline

" attempt to keep at least 5 lines below the cursor
set scrolloff=5

" always show the status line
set laststatus=2

" store swapfiles in the vim directory
set directory^=$HOME/Mac/.mac/packages/vim/swap//

" disable visual bell as screen flashes aren't ideal

" use a nicer leader shorcut
let mapleader=";"

" move up and down by visual lines instead of lines in a file e.g. due to text wrapping
nnoremap j gj
nnoremap k gk

" enable easier navigation of location lists
nnoremap <Leader>j :lnext<CR>
nnoremap <Leader>k :lprevious<CR>

" navigate easily between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

