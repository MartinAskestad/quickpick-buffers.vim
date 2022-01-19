if !exists('g:quickpick_buffers_reuse_window')
  let g:quickpick_buffers_reuse_window=0
endif
function! quickpick#pickers#buffers#open() abort
  call quickpick#open({
        \ 'filter': 0,
        \ 'items': s:get_buffers(),
        \ 'on_accept': function('s:on_accept'),
        \ 'on_change': function('s:on_change')
        \ })
endfunction

function! s:get_buffers() abort
  let s:buffers = []
  for buf in getbufinfo({'buflisted':1})
    call add(s:buffers, buf.name)
  endfor
  return s:buffers
endfunction

function! s:on_accept(data, name) abort
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

function! s:on_change(data, name) abort
  if empty(a:data['input'])
    call quickpick#items(s:buffers)
  else
    if exists('matchfuzzy')
      let l:buffers = matchfuzzy(s:buffers, a:data['input'])
    else
      let l:buffers = filter(copy(s:buffers), 'stridx(toupper(v:val), toupper(a:data["input"])) >= 0')
    endif
    call quickpick#items(l:buffers)
  endif
endfunction
" vim: tabstop=2 shiftwidth=2 expandtab
