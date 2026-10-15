#!/usr/bin/env bash
set -e

DOTFILES="$HOME/dotfiles"
PACKAGES="nvim zsh fastfetch tmux kitty niri noctalia"

echo "== Checking dependencies =="

# stow
if ! command -v stow &>/dev/null; then
    echo "Installing stow..."
    sudo pacman -S --noconfirm stow
fi

# pokeget (used by fastfetch)
if ! command -v pokeget &>/dev/null; then
    echo "Installing pokeget..."
    paru -S --noconfirm pokeget
fi

# oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# powerlevel10k (needed for .p10k.zsh to actually do anything)
P10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
    echo "Installing powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

echo
echo "== Stowing dotfiles =="
cd "$DOTFILES"
for pkg in $PACKAGES; do
    if [ -d "$pkg" ]; then
        stow -v "$pkg"
    fi
done

echo
echo "== Done =="
echo "Restart your shell or run: exec zsh"
echo "For niri/noctalia, make sure those packages themselves are installed via your package manager first."
