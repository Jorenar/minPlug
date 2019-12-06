" minPlug - Most minimalistic plugin "manager" I could heve come up with
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_minPlug') | finish | endif

let s:plugins = { "Jorengarenar/minPlug" : "master" }

function! s:MinPlugInstall() abort
    let plugins_dir = substitute(&packpath, ",.*", "/pack/plugins/opt", "")
    call mkdir(plugins_dir, 'p')
    for [plugin, branch] in items(s:plugins)
        let plugin_name = substitute(plugin, ".*\/", "", "")
        let plugin_dir = plugins_dir."/".plugin_name
        let github_url = "https://github.com/".plugin
        let cmd = "git clone --depth=1 -b ".branch." --single-branch ".github_url." ".plugin_dir." 2> /dev/null || (cd ".plugin_dir." ; git pull)"
        call system(cmd)
        execute "packadd ".plugin_name
    endfor
    silent! helptags ALL
    echo "minPlug: DONE"
endfunction

function! s:MinPlug(bang, plugin, ...) abort
    let s:plugins[a:plugin] = get(a:, 1, "master")
    if !a:bang
        execute "silent! packadd! ".substitute(a:plugin, ".*\/", "", "")
    endif
endfunction

command! -bar MinPlugInstall call <SID>MinPlugInstall()
command! -bang -bar -nargs=+ MinPlug call <SID>MinPlug(<bang>0, <f-args>)

let g:loaded_minPlug = 1
