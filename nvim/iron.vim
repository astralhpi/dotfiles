function! GetCellText()
    let cur_line = line('.')

    let start = cur_line
    let end = cur_line + 1

    while start > 0
        if getline(start) == '# %%'
            break
        endif
        let start -= 1
    endwhile

    while end < line('$')
        if getline(end) == '# %%'
            break
        endif
        let end += 1
    endwhile

    let lines = []

    for i in range(start, end)
        call add(lines, getline(i))
    endfor

    return lines
endfunction

function! IronRunCell()
    for line in GetCellText()
        if line
            execute ':IronSend! ' . line
        endif
    endfor
endfunction

function! IronRun() 
    let line = getline('.')
    if line
        execute ':IronSend! ' . line
    endif
endfunction
map ® :call IronRun()<CR>
map † :call IronRunCell()<CR>
