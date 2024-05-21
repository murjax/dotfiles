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
