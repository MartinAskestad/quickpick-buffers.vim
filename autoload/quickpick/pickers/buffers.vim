if !exists('g:quickpick_buffers_reuse_window')
  let g:quickpick_buffers_reuse_window=0
endif
function! quickpick#pickers#buffers#open() abort
  call quickpick#open({
        \ 'items': s:get_buffers(),
        \ 'on_accept': function('s:on_accept')
        \ })
endfunction

function! s:get_buffers() abort
  let buffers = []
  for buf in getbufinfo({'buflisted':1})
    call add(buffers, buf.name)
  endfor
  return buffers
endfunction

function! s:on_accept(data, ...) abort
  call quickpick#close()
  let selected_buffer_path = a:data['items'][0]
  let wnr = bufwinnr(selected_buffer_path)
  let bfnr = bufnr(selected_buffer_path)
  if g:quickpick_buffers_reuse_window && wnr > -1
    echom 'wnr ' . wnr
    execute wnr . 'wincmd w'
  else
    execute 'b ' . bfnr
  endif
endfunction

" vim: tabstop=2 shiftwidth=2 expandtab
