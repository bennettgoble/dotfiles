packadd! onedark.vim
colorscheme onedark

"set swapfile
"set dir=~/tmp
"set backupcopy=yes
set hlsearch
set number
set mouse=a

let mapleader=','

" vv to generate new vertical split
nnoremap <silent> vv <C-w>v

" ctrlp configuration
let g:ctrlp_map = '<c-p>'
let g:ctrlp_custom_ignore = {
  \ 'dir': '\.git$\|\.hg$\|\.svn$\|vendor$\|node_modules$',
  \ 'file': '\.exe$\|\.so$\|\.dat$'
  \ }

" vimux
map <Leader>vp :VimuxPromptCommand<CR>
map <Leader>vl :VimuxRunLastCommand<CR>

" start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" matchit, better %
runtime macros/matchit.vim

" strip trailing whitespace
function! StripWhitespace ()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" trialing white space (strip spaces)
noremap <leader>ss :call StripWhitespace()<CR>

fun CopyText(text)
  if executable('wl-copy')
    silent! call system('wl-copy', a:text)
    return 1
  elseif executable('xclip')
    silent! call system('xclip -sel clip', a:text)
    return 1
  else
    echo "No clipboard command found: wl-copy, xclip."
    return 0
  endif
endfun

" LSL Optimizer
function CompileLSL()
  let lslopt_flags = $LSLOPT_FLAGS
  if $lslopt_flags == ""
    let $lslopt_flags = "-P \"-I\" -H -O addstrings,-extendedglobalexpr -p gcpp --precmd=cpp"
  endif
  let out = system($LSL_OPTIMIZER . " " . $lslopt_flags . " " . expand("%:p"))
  if v:shell_error != 0
    echo out
  else
    let ret = CopyText(out)
    if ret == 1
      echo "LSL output copied to clipboard"
    endif
  endif
endfunction

autocmd FileType lsl nnoremap <F5> :call CompileLSL()<CR>

if &diff
  map ] ]c
  map [ [c
endif
