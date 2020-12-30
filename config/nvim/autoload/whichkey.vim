fun! whichkey#fix(cmd)
  if a:cmd == 'quit'
    if len(getbufinfo({'buflisted':1})) > 1 | exec ":bd" | else | exec ":q" | endif
  elseif a:cmd == 'toggletab'
    if tabpagenr() == 1 | exec ':tabedit %' | else | exec ':tabclose' | endif
  elseif a:cmd == 'replaceword'
    if mode() ==? 'v'
      call feedkeys(":s///gc\<left>\<left>\<left>")
    else
      call feedkeys(":%s///gc\<left>\<left>\<left>")
    endif
  elseif a:cmd == 'comment'
    if mode() ==? 'v'
      call feedkeys('gc')
    else
      if v:count | call feedkeys('gc'.(v:count1-1).'j') | else | call feedkeys('gcc') | endif
    endif
  elseif a:cmd == 'newfile'
    call inputsave()
      let fname = input('Create file: ')
      if fname != "" | exec 'e ' . expand('%:h') . '/' . fname | endif
    call inputrestore()
  elseif a:cmd == 'regsend' | exec "normal! \"Xdd"
  elseif a:cmd == 'regpaste' | exec "normal! \"xpqxq"
  elseif a:cmd == 'cocsearch' | exec "CocSearch " . expand("<cword>")
  elseif a:cmd == 'delete' | enew | execute('!rm ' . expand("#")) | bwipe#
  else | return | endif
endf
