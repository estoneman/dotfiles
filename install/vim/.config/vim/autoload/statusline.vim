function statusline#RegOrNetrw()
  if &filetype == 'netrw'
    return "%<netrw %m%r"
  else
    return '%<%t %y bufnr=%n %h%w%m%r%=%-14.(%l,%c%V%) %P'
  endif
endfunction
