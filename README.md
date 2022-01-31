# Setup

* Clone this repository to `~/.config/nvim` (Linux) or `%appdata%/Local/nvim` (Windows)
* Install vim-plug (https://github.com/junegunn/vim-plug)
* Install neovim with pip3
  * Ensure that `:echo has("python3")` returns `1`
* Install plugins by opening neovim and running :PlugInstall

isc config:
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

# Troubleshooting

## E492: Not an editor command: ^M

Either the config file or the plugins are downloaded with the wrong line break characters. This is likely because `autocrlf` was set to true on a Linux machine.

Fix:
```
git config --global core.autocrlf false
```
Or if it's an issue with the `init.vim` file, then run this locally in this repo's directory (i.e. without the `--global` flag).
