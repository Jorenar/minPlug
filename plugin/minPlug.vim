" minPlug
" Maintainer: Jorengarenar <https://joren.ga>
" License:    MIT

if exists('g:loaded_minPlug') | finish | endif
let s:cpo_save = &cpo | set cpo&vim

let s:plugins = { "Jorengarenar/minPlug" : "master" }

function! s:install(b) abort
  let packDir = substitute(&packpath, ",.*", "", "")."/pack/plugins/opt"
  let override = a:b ? "(git reset --hard HEAD && git clean -f -d); " : ""
  sil! call mkdir(packDir, 'p')
  for [plugin, branch] in items(s:plugins)
    let name = substitute(plugin, ".*\/", "", "")
    let dir = packDir."/".name
    let url = "https://github.com/".plugin
    call system("git clone --recurse --depth=1 -b ".branch." --single-branch ".url.
          \ " ".dir." 2> /dev/null || (cd ".dir." ; ".override."git pull)")
    exe "pa ".name
  endfor
  sil! helpt ALL
  ec "minPlug: DONE"
endfunction

function! s:minPlug(b, plugin, ...) abort
  let s:plugins[a:plugin] = get(a:, 1, "master")
  if !a:b
    exe "sil! pa ".substitute(a:plugin, ".*\/", "", "")
  endif
endfunction

com! -bang -bar MinPlugInstall call <SID>install(<bang>0)
com! -bang -bar -nargs=+ MinPlug call <SID>minPlug(<bang>0, <f-args>)

let g:loaded_minPlug = 1
let &cpo = s:cpo_save | unlet s:cpo_save
