# Setup

* Clone this repository to `~/.config/nvim` (Linux) or `%appdata%/Local/nvim` (Windows)
* Install vim-plug (https://github.com/junegunn/vim-plug)
* Install neovim with pip3
  * Ensure that `:echo has("python3")` returns `1`
* Install plugins by opening neovim and running :PlugInstall

Misc config:
* Add `set -sg escape-time 0` to `.tmux.conf`
* Install coc extensions
  * `:CocInstall coc-pyright` for python

Install new plugins, update, and clear removed plugins
```
:PlugInstall
:PlugUpdate
:PlugClean
```

Setup Copilot
```
:Copilot setup
```
