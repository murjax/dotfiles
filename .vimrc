call plug#begin('~/.config/nvim')

" Use shortcuts gJ and gS to join and split, respectively
Plug 'AndrewRadev/splitjoin.vim' " Convert between do/end and {}
" Show git diffs while editing a file
Plug 'airblade/vim-gitgutter'
Plug 'bronson/vim-trailing-whitespace'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Optional if fzf
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify' " Always update session on vim close
" j and k keys move faster when held down
Plug 'rhysd/accelerated-jk'
Plug 'sheerun/vim-polyglot'
" See git diff in commit window as another pane
Plug 'rhysd/committia.vim'
Plug 'thoughtbot/vim-rspec'
Plug 'tomtom/tcomment_vim' " Universal comment tool
Plug 'tpope/vim-endwise' " Completes ruby blocks
Plug 'tpope/vim-eunuch' " File operation helper
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine' " Display thin vertical lines at code indentation levels
Plug 'jgdavey/tslime.vim' " Allows commands to be sent from vim buffer to tmux session

" Theme
" Plug 'w0ng/vim-hybrid'
Plug 'folke/tokyonight.nvim'

" LSP with lsp-zero
Plug 'VonHeikemen/lsp-zero.nvim', { 'branch': 'v3.x' }
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'roobert/tailwindcss-colorizer-cmp.nvim'

call plug#end()

set termguicolors
set t_Co=256

set autoindent
set autoread
set colorcolumn=80,120
set expandtab
set ignorecase
set noerrorbells
set mouse=
set number
set nowrap
set numberwidth=5
set rtp+=/usr/local/opt/fzf
set showtabline=2
set smartcase
set tabstop=2
set list listchars=tab:»·,trail:·,nbsp:·
colorscheme tokyonight

" Visual select shift mappings
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
vnoremap > >gv
vnoremap < <gv

" Replace old school ruby hashes with modern day syntax
nnoremap hs :%s/:\([^ ]*\)\(\s*\)=>/\1:/g
" Clear search highlighting by pressing //
noremap // :noh<cr>
" bind K to ripgrep word under cursor
nnoremap K :Find <cr>
nnoremap F :Files<cr>

" Change line numbers so they're readable https://stackoverflow.com/a/32128209/2892779
highlight LineNr term=bold cterm=NONE ctermfg=LightGrey ctermbg=NONE gui=NONE guifg=Grey80 guibg=NONE

augroup vimrc_autocmd
  " Make fzf quit quickly when esc is pressed
  " https://github.com/junegunn/fzf/issues/1393#issuecomment-426576577
  autocmd! FileType fzf tnoremap <buffer> <esc> <c-c>
augroup END

let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "!{.git,log,coverage,node_modules,vendor,frontend,tmp}/*"
  \ -g "!tmux*"
  \ -g "!*.log"
  \ -g "!tags"
  \ '
"   " \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"

command! -bang -nargs=* Rg
\ call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1,
\ <bang>0 ? fzf#vim#with_preview('up:60%')
\         : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" This command is used with a shortcut key below to find all occurences of the
" word beneath the cursor
command! -bang -nargs=* Find
\ call fzf#vim#grep(g:rg_command .shellescape(expand('<cword>')), 1,
\ <bang>0 ? fzf#vim#with_preview('up:60%')
\         : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

" Open scratch files by extension in dedicated scratch directory
command -nargs=1 Scratch tabedit ~/scratch/scratch.<args>

augroup RubyStuff
	autocmd!
  map <Leader>t :call RunCurrentSpecFile()<CR>
  map <Leader>s :call RunNearestSpec()<CR>
  map <Leader>l :call RunLastSpec()<CR>
  map <Leader>a :call RunAllSpecs()<CR>
  map <Leader>u :call Send_to_Tmux("!!\n")<CR>
augroup END
let g:rspec_command = 'call Send_to_Tmux("bundle exec rspec {spec}\n")'
