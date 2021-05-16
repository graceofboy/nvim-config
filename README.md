# vim-plug
```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```
# Binary
## step1
:GoInstallBinaries
## step2
:CocInstall coc-go
## step3
:CocConfig
```
{
  "languageserver": {
		"go": {
			"command": "gopls",
			"rootPatterns": ["go.mod"],
			"trace.server": "verbose",
			"filetypes": ["go"]
		}
	}
}

```
# use
```
ln -sf init.vim ~/.config/nvim/init.vim
```
