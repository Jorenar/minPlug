" minPlug
" Maintainer: Jorengarenar <https://joren.ga>
" License:    MIT

if exists('g:loaded_minPlug') | finish | endif
let s:cpo_save = &cpo | set cpo&vim

let s:plugins = { "Jorengarenar/minPlug" : "master" }

fu! s:install(b) abort
  let packDir = substitute(&packpath, ",.*", "", "")."/pack/plugins"
  let override = a:b ? "(git reset --hard HEAD && git clean -f -d); " : ""
  sil! call mkdir(packDir."/opt", 'p')
  for [plugin, branch] in items(s:plugins)
    let name = substitute(plugin, ".*\/", "", "")
    let [ dir, url ] = [ packDir."/opt/".name, "https://github.com/".plugin ]
    call system("git clone --recurse --depth=1 -b ".branch." --single-branch ".url.
          \ " ".dir." 2> /dev/null || (cd ".dir." ; ".override."git pull)")
    exe "pa ".name
  endfor
  sil! helpt ALL
  for [ name, foo ] in items(get(g:, "minPlug_singleFiles", {}))
    let dir = packDir."/start/singleFiles/".foo[0]
    call system("curl --create-dirs -o ".dir."/".name." -L ".foo[1])
  endfor
  ec "minPlug: DONE"
endf

fu! s:minPlug(b, plugin, ...) abort
  let s:plugins[a:plugin] = get(a:, 1, "master")
  if !a:b
    exe "sil! pa! ".substitute(a:plugin, ".*\/", "", "")
  endif
endf

com! -bang -bar MinPlugInstall call <SID>install(<bang>0)
com! -bang -bar -nargs=+ MinPlug call <SID>minPlug(<bang>0, <f-args>)

let g:loaded_minPlug = 1
let &cpo = s:cpo_save | unlet s:cpo_save
