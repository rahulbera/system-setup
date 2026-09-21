# JetBrains-style Vim Setup

A modern, IDE-like Vim configuration based on the guide
[*From JetBrains to Vim*](https://medium.com/@devsjc/from-jetbrains-to-vim-a-modern-vim-configuration-and-plugin-set-d58472a7d53d)
by devsjc, customized for C/C++, Python and Bash. This README gives you the
final `vimrc`, the commands to install it, and the external binaries it depends
on.

> **Source of truth.** The files next to this README are the live config:
> `vimrc` is `~/.vim/vimrc`, and `pack.tar.gz` is a snapshot of `~/.vim/pack`
> with every plugin at the exact commit in use. The vimrc embedded
> [below](#the-vimrc) is a copy of the same file.

> **Requires Vim 9.0+** — the `yegappan/lsp` plugin is written in Vim9script and
> will not load on Vim 8. Ubuntu 24.04's `vim` package is 9.1; Ubuntu 22.04 ships
> 8.2, which is too old. Check your version with:
> ```bash
> vim --version | head -1
> ```

All commands below are run from the root of the `system-setup` repo.

---

## 1. Install external binaries

The config assumes a truecolor terminal and a few external tools. The **fzf
binary ships inside `pack.tar.gz`** (or is downloaded by the `junegunn/fzf`
plugin during `:PackagerInstall`), so it is not listed below.

### Debian / Ubuntu

```bash
# Editor + tooling
sudo apt update
sudo apt install -y vim git silversearcher-ag      # ag powers :Ag (<leader>F)

# Language servers, linters and fixers (the LSP plugin and ALE do NOT install these)
sudo apt install -y clangd cppcheck clang-format   # C/C++: LSP, linter, fixer
sudo apt install -y shellcheck shfmt               # Bash: linter, fixer
sudo apt install -y nodejs npm pipx
sudo npm install -g bash-language-server           # Bash LSP
pipx install python-lsp-server                     # Python LSP (pylsp)
pipx install ruff                                  # Python linter + fixer
pipx install mypy                                  # Python type checker
```

`pipx` installs into `~/.local/bin`, which the repo's `bashrc` already puts on
`PATH`. (Plain `pip install --user` is refused on Ubuntu 24.04 with
`externally-managed-environment`, which is why this uses `pipx`.)

### macOS (Homebrew)

```bash
brew install vim git the_silver_searcher cppcheck shellcheck shfmt llvm pipx node
npm install -g bash-language-server
pipx install python-lsp-server && pipx install ruff && pipx install mypy
# clangd and clang-format come from llvm, which Homebrew does not link onto PATH:
export PATH="$(brew --prefix llvm)/bin:$PATH"
```

### Icons (optional but recommended)

Install and select a **Nerd Font** in your terminal. Without one, the devicons
in Fern and the statusline render as empty boxes. Everything else works
regardless. To check whether your terminal already has one:

```bash
printf '\ue606 \ue61d \ue613\n'   # Python, C++ and folder icons
```

Over SSH, the font must be installed on the machine you type on, not the
server: the local terminal draws the glyphs.

---

## 2. Install the vimrc and plugins

The config lives at **`~/.vim/vimrc`** — *not* `~/.vimrc`. If a `~/.vimrc`
already exists, Vim uses it *instead* and ignores `~/.vim/vimrc`, so both
options below move any existing one out of the way first.

### Option A — restore the exact snapshot (recommended)

This reproduces the plugin set exactly, with no network access needed:

```bash
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak           # back up any existing config
[ -d ~/.vim/pack ] && mv ~/.vim/pack ~/.vim/pack.bak  # back up any existing plugins
mkdir -p ~/.vim
cp vim/vimrc vim/README.md ~/.vim/
tar xzf vim/pack.tar.gz -C ~/.vim                     # creates ~/.vim/pack/packager/...
ln -sfn ~/.vim/pack/packager/start/fzf ~/.fzf         # what the fzf plugin's install hook does
```

Every plugin in the snapshot is a full git clone, so `:PackagerUpdate` still
works later. The bundled fzf binary is x86_64 Linux; on any other architecture,
use option B.

### Option B — fresh install via vim-packager (latest plugin versions)

The config uses [vim-packager](https://github.com/kristijanhusak/vim-packager)
to manage plugins, but packager itself must be cloned once by hand
(chicken-and-egg). It must live in the `opt` directory to match
`packadd vim-packager`:

```bash
[ -f ~/.vimrc ] && mv ~/.vimrc ~/.vimrc.bak
mkdir -p ~/.vim
cp vim/vimrc vim/README.md ~/.vim/
git clone https://github.com/kristijanhusak/vim-packager \
  ~/.vim/pack/packager/opt/vim-packager
vim
```

On this **first launch you will see errors** flash by (undefined functions
`LspOptionsSet` / `LspAddServer`) — this is expected, because the plugins are
not cloned yet. Press `Enter` through them, then run:

```
:PackagerInstall
```

Wait for it to clone everything and build the fzf binary, then **quit and reopen
Vim**. Everything resolves on the second launch.

fzf's install hook (`./install --all`) also creates `~/.fzf` and writes its own
`~/.fzf.bash`. Replace that with the repo's version, which puts the plugin's fzf
on `PATH` ahead of Ubuntu's older apt `fzf`:

```bash
cp fzf.bash ~/.fzf.bash
```

---

## 3. Verify

Inside Vim:

```
:PackagerStatus        " every plugin listed as installed
:LspShowAllServers     " clangd / pylsp / bashls (open a matching file first)
:ALEInfo               " linters/fixers found for the current file
```

---

## Pinned plugin versions

The versions in `pack.tar.gz`:

| Plugin                                  | Commit    |
| --------------------------------------- | --------- |
| kristijanhusak/vim-packager (`opt`)     | `601453a` |
| junegunn/fzf (binary 0.74.0)            | `24832e9` |
| junegunn/fzf.vim                        | `d2a59a9` |
| yegappan/lsp                            | `989016a` |
| dense-analysis/ale                      | `d0ea943` |
| 907th/vim-auto-save                     | `2e3e54e` |
| jiangmiao/auto-pairs                    | `39f06b8` |
| airblade/vim-gitgutter                  | `21c977e` |
| bluz71/vim-mistfly-statusline           | `da22cc6` |
| janko-m/vim-test                        | `2676d84` |
| tpope/vim-dispatch                      | `a2ff28a` |
| sainnhe/sonokai                         | `b023c52` |
| sheerun/vim-polyglot                    | `f061edd` |
| lambdalisue/fern.vim                    | `3d58035` |
| lambdalisue/fern-git-status.vim         | `1513363` |
| lambdalisue/fern-renderer-devicons.vim  | `d0f7264` |
| lambdalisue/fern-hijack.vim             | `f655248` |
| ryanoasis/vim-devicons                  | `71f239a` |
| liuchengxu/vim-which-key                | `72a4267` |

To refresh the snapshot after updating plugins on a machine:

```bash
tar czf vim/pack.tar.gz -C ~/.vim pack
```

---

## The vimrc

Save this as `~/.vim/vimrc` (it is identical to `vim/vimrc` in this repo):

```vim
"=== VIM SETTINGS ===================================="

unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim

syntax enable
filetype plugin indent on
set hlsearch incsearch ignorecase
set number
set encoding=UTF-8

if $COLORTERM == 'truecolor'
  set termguicolors
endif

let mapleader="\<space>"
nnoremap <leader>c :botright term<CR>

"=== PLUGINS ========================================"

function! s:packager_init(packager) abort
    call a:packager.add('kristijanhusak/vim-packager', { 'type': 'opt' })
    call a:packager.add('junegunn/fzf', { 'do': './install --all && ln -s $(pwd) ~/.fzf' })
    call a:packager.add('junegunn/fzf.vim')
    call a:packager.add('yegappan/lsp')
    call a:packager.add('dense-analysis/ale')
    call a:packager.add('907th/vim-auto-save')
    call a:packager.add('jiangmiao/auto-pairs')
    call a:packager.add('airblade/vim-gitgutter')
    call a:packager.add('bluz71/vim-mistfly-statusline')
    call a:packager.add('janko-m/vim-test', { 'requires': 'tpope/vim-dispatch' })
    call a:packager.add('sainnhe/sonokai')
    call a:packager.add('sheerun/vim-polyglot')
    call a:packager.add('lambdalisue/fern.vim', { 'requires': [
      \ 'lambdalisue/fern-git-status.vim',
      \ 'lambdalisue/fern-renderer-devicons.vim',
      \ 'lambdalisue/fern-hijack.vim'] })
    call a:packager.add('ryanoasis/vim-devicons')
    call a:packager.add('liuchengxu/vim-which-key')
endfunction

packadd vim-packager
call packager#setup(function('s:packager_init'))

"=== PLUGIN CONFIG =================================="

"--- WhichKey settings ---------------------------------------------"
"Put this before any of the other plugin-specific config
let g:mapleader = "\<Space>"
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
set timeoutlen=200

"--- FZF settings --------------------------------"
nnoremap <silent> <leader>f :Lines<CR>
nnoremap <silent> <leader>F :Ag<CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>g :GFiles<CR>
"Map buffer quick switch keys
nnoremap <silent> <leader><Tab> <C-^>

"--- LSP settings ---------------------------------------------------"
let lspOptions = #{
    \ aleSupport: v:true,
    \ autoHighlight: v:true,
    \ completionTextEdit: v:true,
    \ noNewlineInCompletion: v:true,
    \ outlineOnRight: v:true,
    \ outlineWinSize: 70,
    \ showDiagWithSign: v:false,
    \ useQuickfixForLocations: v:true,
    \ }
autocmd VimEnter * call LspOptionsSet(lspOptions)

let lspServers = [
    \ #{ name: 'clangd', filetype: ['c', 'cpp'],   path: 'clangd', args: ['--background-index'] },
    \ #{ name: 'pylsp',  filetype: ['python'],      path: 'pylsp',  args: []                     },
    \ #{ name: 'bashls', filetype: ['sh', 'bash'],  path: 'bash-language-server', args: ['start'] },
\ ]
autocmd VimEnter * call LspAddServer(lspServers)

"Enable auto selection of the first autocomplete item
augroup LspSetup
    au!
    au User LspAttached set completeopt-=noselect
augroup END
"Disable newline on selecting completion option
inoremap <expr> <CR> pumvisible() ? "\<C-Y>" : "\<CR>"

"Mappings for most-used functions
nnoremap <leader>i :LspHover<CR>
nnoremap <leader>d :LspGotoDefinition<CR>
nnoremap <leader>p :LspPeekDefinition<CR>
nnoremap <leader>R :LspRename<CR>
nnoremap <leader>r :LspPeekReferences<CR>
nnoremap <leader>o :LspDocumentSymbol<CR>

"--- ALE settings ------------------------------------------------------"
"Disable ALE's LSP in favour of standalone LSP plugin
let g:ale_disable_lsp = 1

"Show linting errors with highlights
"* Can also be viewed in the loclist with :lope
let g:ale_set_signs = 1
let g:ale_set_highlights = 1
let g:ale_virtualtext_cursor = 1
highlight ALEError ctermbg=none cterm=underline

"Define when to lint
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_change = 'never'

"Set linters for individual filetypes
let g:ale_linters_explicit = 1
let g:ale_linters = {
    \ 'c':      ['cppcheck'],
    \ 'cpp':    ['cppcheck'],
    \ 'python': ['ruff', 'mypy'],
    \ 'sh':     ['shellcheck'],
\ }
"Specify fixers for individual filetypes
let g:ale_fixers = {
    \ '*':      ['trim_whitespace'],
    \ 'c':      ['clang-format'],
    \ 'cpp':    ['clang-format'],
    \ 'python': ['ruff'],
    \ 'sh':     ['shfmt'],
\ }
"Don't warn about trailing whitespace, as it is auto-fixed by '*' above
let g:ale_warn_about_trailing_whitespace = 0
"Show info, warnings, and errors; Write which linter produced the message
let g:ale_lsp_show_message_severity = 'information'
let g:ale_echo_msg_format = '[%linter%] [%severity%:%code%] %s'
"Specify Containerfiles as Dockerfiles
let g:ale_linter_aliases = {"Containerfile": "dockerfile"}

"Mapping to run fixers on file
nnoremap <leader>L :ALEFix<CR>

"--- AutoSave settings ---------------------------------------------"
set noswapfile

let g:auto_save = 1
let g:auto_save_silent = 1
let g:auto_save_events = ["InsertLeave", "TextChanged", "FocusLost"]

"--- Mistfly statusline settings ------------------------------------------"
"Don't show the mode as it is present in statusline; always show the statusline
set noshowmode laststatus=2

"--- Vim Test settings -----------------------------------------------"
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>

let test#strategy = "dispatch"

"--- Colorscheme -----------------------------------------------------"
silent! colorscheme sonokai

"--- Fern Filetree settings -------------------------------------------"
let g:fern#renderer = "devicons"
let g:fern#default_hidden = 1
let g:fern#default_exclude = '\%(\.DS_Store\|__pycache__\|.pytest_cache\|.ruff_cache\|.git\)'

nnoremap <leader>a :Fern . -drawer -toggle<CR>
```

---

## Key mappings

Leader key is `<Space>`.

| Mapping        | Action                                        |
| -------------- | --------------------------------------------- |
| `<leader>f`    | Fuzzy search lines in open buffers (`:Lines`) |
| `<leader>F`    | Search file contents across the project (`:Ag`) |
| `<leader>g`    | List git-tracked files (fuzzy)                |
| `<leader>b`    | List open buffers                             |
| `<leader><Tab>`| Switch to last-used buffer                    |
| `<leader>c`    | Open a terminal along the bottom              |
| `<leader>i`    | LSP hover / docs                              |
| `<leader>d`    | Go to definition                              |
| `<leader>p`    | Peek definition                               |
| `<leader>r`    | Peek references                               |
| `<leader>R`    | Rename symbol (all uses)                      |
| `<leader>o`    | Document symbol outline                       |
| `<leader>L`    | Run ALE fixers / format file                  |
| `<leader>a`    | Toggle Fern file tree                         |
| `<leader>tn`   | Run nearest test                              |
| `<leader>tf`   | Run tests in file                             |
| `<leader>ts`   | Run test suite                                |
| `<leader>tl`   | Re-run last test                              |
| `<leader>`     | Show WhichKey cheat sheet (after 200ms)       |

---

## Language support

| Language  | LSP (`yegappan/lsp`)           | Linters (ALE) | Fixers (`<leader>L`) |
| --------- | ------------------------------ | ------------- | -------------------- |
| C / C++   | `clangd --background-index`    | `cppcheck`    | `clang-format`       |
| Python    | `pylsp`                        | `ruff`, `mypy`| `ruff`               |
| Bash / sh | `bash-language-server start`   | `shellcheck`  | `shfmt`              |
| all files | —                              | —             | `trim_whitespace`    |

`g:ale_linters_explicit = 1`, so ALE runs only the linters listed above. A
missing binary is skipped silently; `:ALEInfo` shows what was found.

clangd works best with a `compile_commands.json` in the project root. With CMake,
generate one via `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`, which is what makes clangd
resolve include paths correctly in large projects.

To add a language, add an entry to `lspServers` plus `g:ale_linters` /
`g:ale_fixers`. For example, Go (from the original devsjc config, after
`go install golang.org/x/tools/gopls@latest`):

```vim
\ #{ name: 'gopls', filetype: ['go', 'gomod'], path: 'gopls', args: ['serve'] },
```

---

## Notes / gotchas

- **`~/.vim/vimrc` vs `~/.vimrc`.** If both exist, Vim reads `~/.vimrc` and
  silently ignores `~/.vim/vimrc`. Keep only one.
- **First-launch errors are normal** with option B. They disappear once
  `:PackagerInstall` has run and Vim is restarted. Option A has none.
- **Icons come from `ryanoasis/vim-devicons`.** Fern's `devicons` renderer
  needs it; without it, Fern logs `WebDevIconsGetFileTypeSymbol is not found`
  and falls back to its plain renderer. The mistfly statusline also picks it up
  and shows a filetype icon. Both need a Nerd Font in the terminal.
- **Autosave is on and swapfiles are off.** Buffers are written on
  `InsertLeave`, `TextChanged` and `FocusLost`.
- **fzf on the shell side.** `~/.fzf` must point at the plugin's fzf directory,
  and the repo's `fzf.bash` (sourced from `bashrc`) puts that fzf first on
  `PATH`, because Ubuntu's apt `fzf` (0.44) lacks the `--bash` option.

---

*Config adapted from devsjc's [GitHub gist](https://gist.github.com/devsjc/6d9f2c377a6b5695ef64160b230d7f47).*
