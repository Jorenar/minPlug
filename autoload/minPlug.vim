" minPlug - Most minimalistic plugin "manager" I could heve come up with
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_minPlug') | finish | endif

function! minPlug#()
endfunction

let s:plugins_dir = substitute(&packpath, ",.*", "", "")."/pack/plugins/opt"
call mkdir(s:plugins_dir, 'p')

let s:plugins = { "Jorengarenar/minPlug" : "master" }

function! s:GetPlugins()
    for [plugin, branch] in items(s:plugins)
        let plugin_name = substitute(plugin, ".*\/", "", "")
        let plugin_dir = s:plugins_dir."/".plugin_name
        let github_url = "https://github.com/".plugin
        let cmd = "git clone --depth=1 -b ".branch." --single-branch ".github_url." ".plugin_dir." 2> /dev/null || (cd ".plugin_dir." ; git pull)"
        call system(cmd)
        execute "packadd ".plugin_name
    endfor
    silent! helptags ALL
    echo "minPlug: DONE"
endfunction

function! s:MinPlug(plugin, ...) abort
    let s:plugins[a:plugin] = get(a:, 1, "master")
    execute "silent! packadd ".substitute(a:plugin, ".*\/", "", "")
endfunction

command! MinPlugInstall call <SID>GetPlugins()
command! -nargs=+ MinPlug call <SID>MinPlug(<f-args>)

let g:loaded_minPlug = 1
