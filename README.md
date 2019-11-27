Maybe not as much as a manager, rather a downloader.

The function of this plugin is simple: _download, update and enable using `:packadd`_

It's limited only to GitHub repositories

## Installation

Execute in shell:

```sh
git clone https://github.com/Jorengarenar/minPlug.git ~/.vim/pack/plugin/opt/minPlug/
```

and in _vimrc_ add:

```vim
packadd minPlug | call minPlug#() " initialize minPlug
```

## Usage

This plugin provides two commands: `MinPlug` and `MinPlugInstall`

* **Add plugin**

  After initialization of minPlug, use `MinPlug` in _vimrc_ in such fasion:

```vim
MinPlug "username/repo"
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;To disable plugin, simply comment out this line

* **Download/update plugins**

```vim
:MinPlugInstall
```

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;When it finishes, only the message `DONE` will be shown

* **Delete**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Remove `MinPlug "username/repo"` line from _vimrc_, then go to `~/.vim/pack/plugins/opt` and remove the directory of plugin

---

#### Additional note

If you added something to the `packpath` option, ensure that your desired destination is first in the list (use `^=`, e.g. `set packpath^=$XDG_DATA_HOME/vim`)
