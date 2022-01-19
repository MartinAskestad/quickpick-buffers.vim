if exists('g:quickpick_buffers_loaded')
	finish
endif
let g:quickpick_buffers_loaded=1

command! PBuffers call quickpick#pickers#buffers#open()

" vim: tabstop=2 shiftwidth=2 expandtab
