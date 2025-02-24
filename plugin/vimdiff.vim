" Vim Plugin: Diff Extractor
" Author: Your Name
" Description: Extracts the difference between two files and saves it to a third file

function! DiffToNewFile(file1, file2, outputFile)
  " Read file contents
  let l:cmd = 'diff -u ' . shellescape(a:file1) . ' ' . shellescape(a:file2)
  let l:diff_output = system(l:cmd)

  " Extract only differing lines (ignore headers)
  let l:filtered_diff = []
  for l:line in split(l:diff_output, "\n")
    if l:line =~ '^[-+][^+-]'
      call add(l:filtered_diff, l:line[1:])  " Remove diff symbols
    endif
  endfor

  " Write to output file
  call writefile(l:filtered_diff, a:outputFile)
  echo "Differences saved to " . a:outputFile
endfunction

" Command to call the function
command! -nargs=+ DiffToFile call DiffToNewFile(<f-args>)
