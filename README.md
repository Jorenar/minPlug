# minPlug

Its function is simple: _download, update and enable using `:packadd!`_

It's limited only to GitHub repositories

Best utlized with, nomen omen, minimal list of plugins

<sub>
<code>&lt;PACKDIR&gt;</code> in this README  is a placeholder for
<code>substitute(&packpath, ",.*", "", "")."/pack/plugins"</code>
which by default equals to <code>~/.vim/pack/plugins</code>.
</sub>

## Installation

Execute in shell:

```sh
git clone https://github.com/Jorengarenar/minPlug.git <PACKDIR>/plugins/opt/minPlug/
```

and in _vimrc_ add:

```vim
packadd minPlug " initialize minPlug
```

If you want to have _minPlug_ **automatically installed**, add this to your _vimrc_:

```vim
if empty(glob(substitute(&packpath, ",.*", "", "")."/pack/plugins/opt/minPlug")) " {{{
  call system("git clone --depth=1 https://github.com/Jorengarenar/minPlug ".
        \ substitute(&packpath, ",.*", "", "")."/pack/plugins/opt/minPlug")
  autocmd VimEnter * silent! MinPlugInstall | echo "minPlug: INSTALLED"
endif " }}}
```

## Usage

### Add plugin

After initialization of minPlug, use `MinPlug` in _vimrc_ in such fasion:

```vim
MinPlug username/repo branch
```

If `branch` isn't provided, as defualt `master` will be used

To disable plugin, simply comment out this line

Practiacal example: `MinPlug Jorengarenar/miniSnip`

### Single files

If you don't want to download whole repository just for one file (e.g. colorscheme),
just add it to `g:minPlug_singleFiles` list variable in the following manner:
```vim
let g:minPlug_singleFiles = [
      \   [ "subdir/filename", "URL", "basedir" ],
      \ ]
```

`basedir` is optional and defaults to `<PACKDIR>/start/singleFiles`.

File from `URL` will be saved as `filename` in `subdir` of `basedir`

_That means it will be loaded even if entry was to be deleted from the list!_

Example:
```vim
let g:minPlug_singleFiles = [
      \   "[ colors/darkness.vim"   , "https://raw.githubusercontent.com/Jorengarenar/vim-darkness/master/colors/darkness.vim" ],
      \   "[ ftplugin/sql-upper.vim", "https://git.io/JkQjr", "~/.vim" ],
      \ ]
```

_To use this feature you need to have [`curl`](https://curl.se/) installed!_

### On-demand loading

There is no on-demand loading in _minPlug_, but you can do:

```vim
MinPlug! username/repo branch
```

This will only add plugin to list, so you can download it, but it won't start automatically

Then you can use `autocmd` (or _ftplugin_) to load it on demand using `packadd`

Example:

```vim
MinPlug! Jorengarenar/fauxClip | autocmd filetype cpp packadd fauxClip
```

_**Please note, that this way is prone to bugs.**_

### Download/update plugins

```vim
:MinPlugInstall
```

### Download/update plugins overriding local changes

```vim
:MinPlugInstall!
```

### Delete

Remove `MinPlug username/repo` line from _vimrc_, then go to `<PACKDIR>/opt` and remove the directory of plugin

---

## Configuration

* [`packpath`](https://vimhelp.org/options.txt.html#%27packpath%27) - plugins will be downloaded into `pack/plugins/opt` subdir of the first enrty in this option
* `g:minPlug_updateSelf` - whether minPlug should update itself alongside other plugins
* `g:minPlug_singleFiles` - list of files to download
* `g:minPlug_echo` (default: 0) - displaying list of plugins during installation or not
* `g:minPlug_paBang` (default: `!`) - if empty, `MinPlug` will load plugins with `:pa`, otherwise with `:pa!` (read [`:h packadd`](https://vimhelp.org/repeat.txt.html#:packadd))

#### Additional note

If you added something to the `packpath` option, ensure that your desired destination is first in the list  
(use `^=`, e.g. `set packpath^=$XDG_DATA_HOME/vim`)
