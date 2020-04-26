" minPlug - Most minimalistic plugin "manager" I could heve come up with
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_minPlug') | finish | endif

let s:cpo_save = &cpo | set cpo&vim

let s:plugins = { "Jorengarenar/minPlug" : "master" }

function! s:MinPlugInstall(bang) abort
  let plugins_dir = substitute(&packpath, ",.*", "", "")."/pack/plugins/opt"
  let override = a:bang ? "(git reset --hard HEAD && git clean -f -d); " : ""
  silent! call mkdir(plugins_dir, 'p')
  for [plugin, branch] in items(s:plugins)
    let plugin_name = substitute(plugin, ".*\/", "", "")
    let plugin_dir = plugins_dir."/".plugin_name
    let github_url = "https://github.com/".plugin
    call system("git clone --recurse-submodules --depth=1 -b ".branch." --single-branch ".github_url.
          \ " ".plugin_dir." 2> /dev/null || (cd ".plugin_dir." ; ".override."git pull)")
    execute "packadd ".plugin_name
  endfor
  silent! helptags ALL
  echo "minPlug: DONE"
endfunction

function! s:MinPlug(bang, plugin, ...) abort
  let s:plugins[a:plugin] = get(a:, 1, "master")
  if !a:bang
    execute "silent! packadd ".substitute(a:plugin, ".*\/", "", "")
  endif
endfunction

command! -bang -bar MinPlugInstall call <SID>MinPlugInstall(<bang>0)
command! -bang -bar -nargs=+ MinPlug call <SID>MinPlug(<bang>0, <f-args>)

let g:loaded_minPlug = 1

let &cpo = s:cpo_save | unlet s:cpo_save
