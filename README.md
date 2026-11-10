# dotfiles

Personal configuration for my Linux (Xubuntu) setup, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## What's inside

| Package    | Links to                  | Notes                                 |
|------------|---------------------------|---------------------------------------|
| `bash`     | `~/.bashrc`               | Ubuntu defaults + a few aliases       |
| `zsh`      | `~/.zshrc`                | Oh My Zsh, `robbyrussell` theme       |
| `vim`      | `~/.vimrc`                | vim-plug, `vim-one` light theme       |
| `kitty`    | `~/.config/kitty/`        | JetBrains Mono, light theme           |
| `git`      | `~/.gitconfig`            | Identity + `gh` as credential helper  |
| `claude`   | `~/.claude/settings.json` | Claude Code settings only (see below) |
| `githooks` | —                         | gitleaks pre-commit hook for this repo |

## Install

```sh
git clone https://github.com/jmmorell/dotfiles.git ~/dotfiles
cd ~/dotfiles
git config core.hooksPath githooks   # enable the secret-scanning hook
stow bash zsh vim kitty git claude   # pick the packages you want
```

Stow won't overwrite existing files. Back up or remove `~/.bashrc`, `~/.zshrc` and the others first.

### Dependencies

- `stow`, `git`, [`gh`](https://cli.github.com/)
- [Oh My Zsh](https://ohmyz.sh/) for `zsh`
- [vim-plug](https://github.com/junegunn/vim-plug), then `:PlugInstall` in vim
- [kitty](https://sw.kovidgoyal.net/kitty/) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [gitleaks](https://github.com/gitleaks/gitleaks) ≥ 8.19 for the pre-commit hook

## Using it yourself

`git/.gitconfig` contains my name and email. Change the `[user]` section before stowing `git`.

## Claude Code

Only `settings.json` is tracked. `.gitignore` allow-lists `settings.json`, `CLAUDE.md`, `keybindings.json`, `agents/` and `commands/` under `claude/.claude/`. Credentials, transcripts and caches in `~/.claude` are never committed.

Approving "Always allow" in Claude Code writes rules into this file, so review `git diff` before committing.

## Secret scanning

Two layers, both using [gitleaks](https://github.com/gitleaks/gitleaks):

- **Pre-commit hook** (`githooks/pre-commit`): scans staged changes and refuses the commit if a secret is found. Bypass a false positive with `git commit --no-verify`.
- **GitHub Action** (`.github/workflows/gitleaks.yml`): scans the full history on every push and pull request, so anything that slips past the hook still shows up. To bump gitleaks, update `VERSION` and `SHA256` together.

## License

[MIT](LICENSE)
