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
~/dotfiles/install.sh            # all packages
~/dotfiles/install.sh zsh vim    # or just some
```

`install.sh` links the packages with Stow, enables the gitleaks pre-commit hook and lists missing optional dependencies. It's safe to re-run.

Stow never overwrites existing files. If `~/.bashrc` or another target already exists, the script lists the conflicts and stops without linking anything. Back up or remove those files, then re-run.

`~/.config` and `~/.claude` are always created as real directories, so apps never write into this repo.

### Dependencies

- `stow`, `git`, [`gh`](https://cli.github.com/)
- [Oh My Zsh](https://ohmyz.sh/) for `zsh`
- [vim-plug](https://github.com/junegunn/vim-plug), then `:PlugInstall` in vim
- [kitty](https://sw.kovidgoyal.net/kitty/) and [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
- [gitleaks](https://github.com/gitleaks/gitleaks) ≥ 8.19 for the pre-commit hook

## Local overrides

Machine-specific settings and secrets go in untracked files, loaded last so they override the tracked config:

| File                 | Loaded by        |
|----------------------|------------------|
| `~/.bashrc.local`    | `.bashrc`        |
| `~/.zshrc.local`     | `.zshrc`         |
| `~/.gitconfig.local` | `.gitconfig` (`[include]`) |

Installers that append to `~/.bashrc` or `~/.zshrc` still write into the tracked files, so review `git diff` before committing.

## Using it yourself

`git/.gitconfig` contains my name and email. Change the `[user]` section, or override it in `~/.gitconfig.local`.

## Claude Code

Only `settings.json` is tracked. `.gitignore` allow-lists `settings.json`, `CLAUDE.md`, `keybindings.json`, `agents/` and `commands/` under `claude/.claude/`. Credentials, transcripts and caches in `~/.claude` are never committed.

Approving "Always allow" in Claude Code writes rules into this file, so review `git diff` before committing.

## Secret scanning

Two layers, both using [gitleaks](https://github.com/gitleaks/gitleaks):

- **Pre-commit hook** (`githooks/pre-commit`): scans staged changes and refuses the commit if a secret is found. Bypass a false positive with `git commit --no-verify`.
- **GitHub Action** (`.github/workflows/gitleaks.yml`): scans the full history on every push and pull request, so anything that slips past the hook still shows up. To bump gitleaks, update `VERSION` and `SHA256` together.

## License

[MIT](LICENSE)
