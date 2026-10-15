# Dotfiles

Stow-managed dotfiles for nvim, zsh (+ p10k), fastfetch, tmux, kitty, niri, noctalia.

## Fresh install

```bash
git clone <YOUR_REPO_URL> ~/dotfiles
cd ~/dotfiles
./install.sh
```

This installs `stow`, `pokeget`, `oh-my-zsh`, and `powerlevel10k` if missing, then symlinks every package into place.

## Manual re-stow (if configs change)

```bash
cd ~/dotfiles
stow -R nvim zsh fastfetch tmux kitty niri noctalia
```

## Notes
- niri and noctalia themselves must be installed separately via your package manager — this repo only manages their config files.
# dotfiles
