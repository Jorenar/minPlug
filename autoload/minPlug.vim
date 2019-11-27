" minPlug - Most minimalistic plugin "manager" I could heve come up with
" Maintainer:  Jorengarenar <https://joren.ga>

if exists('g:loaded_minPlug') | finish | endif

function! minPlug#()
endfunction

let s:plugins_dir = substitute(&packpath, ",.*", "", "")."/pack/plugins/opt"
call mkdir(s:plugins_dir, 'p')

let s:plugins = [ "Jorengarenar/minPlug" ]

function! s:GetPlugins()
    for plugin in s:plugins
        let plugin_name = substitute(plugin, ".*\/", "", "")
        let plugin_dir = s:plugins_dir."/".plugin_name
        let github_url = "https://github.com/".plugin
        let cmd = "git clone ".github_url." ".plugin_dir." 2> /dev/null || (cd ".plugin_dir." ; git pull)"
        call system(cmd)
        execute "packadd ".plugin_name
    endfor
    silent! helptags ALL
    echo "DONE"
endfunction

command! MinPlugInstall call <SID>GetPlugins()
command! -nargs=1 MinPlug call add(s:plugins, <args>) | execute "silent! packadd ".substitute(<args>, ".*\/", "", "")

let g:loaded_minPlug = 1
