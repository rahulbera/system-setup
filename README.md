# system-setup

My shell and Vim setup, for replicating on a fresh Ubuntu machine. Snapshot
taken from Ubuntu 24.04 (x86_64) with Vim 9.1.

| Repo file         | Installs to        | What it is                                                           |
| ----------------- | ------------------ | -------------------------------------------------------------------- |
| `bashrc`          | `~/.bashrc`        | Bash config: prompt with git branch, aliases, PATH, conda, fzf       |
| `fzf.bash`        | `~/.fzf.bash`      | fzf key bindings and completion, sourced by `bashrc`                 |
| `vim/vimrc`       | `~/.vim/vimrc`     | Vim config (LSP, ALE, fzf, Fern, …)                                  |
| `vim/pack.tar.gz` | `~/.vim/pack/`     | Snapshot of every Vim plugin at the exact commit in use, incl. fzf   |
| `vim/README.md`   | `~/.vim/README.md` | Full Vim guide: dependencies, install options, key mappings, gotchas |

## Setup on a new machine

```bash
git clone https://github.com/rahulbera/system-setup.git ~/system-setup
cd ~/system-setup
```

### 1. Vim

Do this before bash: `fzf.bash` runs the fzf binary that ships inside the Vim
plugin snapshot.

First install the external tools listed in
[vim/README.md § 1](vim/README.md#1-install-external-binaries) (language
servers, linters, `ag`). Then restore the config and plugins:

```bash
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak           # ~/.vimrc would shadow ~/.vim/vimrc
[ -d ~/.vim/pack ] && mv ~/.vim/pack ~/.vim/pack.bak
mkdir -p ~/.vim
cp vim/vimrc vim/README.md ~/.vim/
tar xzf vim/pack.tar.gz -C ~/.vim
ln -sfn ~/.vim/pack/packager/start/fzf ~/.fzf
```

To install the latest plugin versions instead of the snapshot, see
[option B in vim/README.md](vim/README.md#option-b--fresh-install-via-vim-packager-latest-plugin-versions).

### 2. Bash

```bash
sudo apt install -y colordiff          # bashrc aliases diff to colordiff
cp ~/.bashrc ~/.bashrc.bak
cp bashrc ~/.bashrc
cp fzf.bash ~/.fzf.bash
exec bash
```

`bashrc` and `fzf.bash` hardcode `/home/rbera` (the conda, opencode and fzf
paths). If the new machine's username is different, run:

```bash
sed -i "s|/home/rbera|$HOME|g" ~/.bashrc ~/.fzf.bash
```

`bashrc` also expects Miniconda in `~/miniconda3` and opencode in
`~/.opencode/bin`. Neither is required: without them the shell starts normally,
and those commands are just missing.

## Updating this repo from a machine

```bash
cp ~/.bashrc bashrc
cp ~/.fzf.bash fzf.bash
cp ~/.vim/vimrc vim/vimrc
tar czf vim/pack.tar.gz -C ~/.vim pack
```
