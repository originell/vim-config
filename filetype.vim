" user filetype file
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
    au! BufNewFile,BufRead *.applescript            setf applescript
    au! BufNewFile,BufRead syslog*                  setf syslog
    au! BufNewFile,BufRead *Sites/sae/*html         setf php
augroup END
