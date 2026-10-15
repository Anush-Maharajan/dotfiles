# ════════════════════════════════════════════════════════════
#  ~/.zshrc — Oh My Zsh + Powerlevel10k
# ════════════════════════════════════════════════════════════

# ── 1. P10K INSTANT PROMPT ───────────────────────────────────────────────────
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ── 2. OH MY ZSH ─────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git                       # git aliases (gs, ga, gco, etc.)
  zsh-autosuggestions       # fish-like ghost text suggestions
  zsh-syntax-highlighting   # red/green command highlighting
  z                         # frecency-based cd (type: z proj)
  sudo                      # press ESC ESC to prepend sudo
  history-substring-search  # UP/DOWN searches history by typed prefix
  colored-man-pages         # colorized man pages
  copypath                  # copy current path to clipboard
  extract                   # `extract file.tar.gz` — any archive format
  dirhistory                # Alt+Left/Right to navigate dir history
)

source $ZSH/oh-my-zsh.sh

# ── 3. POWERLEVEL10K THEME ───────────────────────────────────────────────────
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme




# ── 5. EDITOR ────────────────────────────────────────────────────────────────
export EDITOR='nvim'
export VISUAL='nvim'
export PAGER='less'
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ── 6. HISTORY ───────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# ── 7. COMPLETION ────────────────────────────────────────────────────────────
autoload -Uz compinit
if [[ -n "$HOME/.zcompdump"(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' group-name ''
# zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' special-dirs false
zstyle ':completion:*:git-checkout:*' sort false

# ── 8. AUTOSUGGESTIONS ───────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'

# ── 9. KEY BINDINGS ──────────────────────────────────────────────────────────
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down

bindkey '^[[H'    beginning-of-line
bindkey '^[[F'    end-of-line
bindkey '^[[3~'   delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H'      backward-kill-word

# ── 10. SHELL OPTIONS ────────────────────────────────────────────────────────
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt CORRECT
setopt INTERACTIVE_COMMENTS
setopt GLOB_DOTS
setopt EXTENDED_GLOB
setopt NO_BEEP

# ── 11. FZF ──────────────────────────────────────────────────────────────────
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

if command -v fzf &>/dev/null; then
  export FZF_DEFAULT_OPTS="
    --height=40% --layout=reverse --border=rounded
    --prompt='❯ ' --pointer='▶' --marker='✓'
    --color=fg:#c0caf5,bg:-1,hl:#bb9af7
    --color=fg+:#c0caf5,bg+:#1a1b26,hl+:#7dcfff
    --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff
    --color=marker:#9ece6a,spinner:#9ece6a
  "
  if command -v fd &>/dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
  fi
fi

# ── 12. ALIASES ──────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'

if command -v eza &>/dev/null; then
  alias ls='eza --icons --group-directories-first'
  alias ll='eza -la --icons --group-directories-first --git'
  alias lt='eza --tree --icons --level=2 --group-directories-first'
  alias la='eza -a --icons --group-directories-first'
else
  alias ls='ls --color=auto'
  alias ll='ls -lah --color=auto'
  alias la='ls -A --color=auto'
fi

if command -v bat &>/dev/null; then
  alias cat='bat --style=plain'
  alias less='bat --style=full'
fi

alias v='nvim'
alias vi='nvim'

alias gl='git log --oneline --graph --decorate --all'
alias gst='git stash'
alias gstp='git stash pop'

alias zrc='nvim ~/.zshrc'
alias p10krc='nvim ~/.p10k.zsh'
alias zsrc='source ~/.zshrc'

alias myip='curl -s ifconfig.me && echo'
alias py='python3'
alias pip='pip3'
alias ff='fastfetch'

# ── 13. PATH ─────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"

# ── 14. ZOXIDE (smart cd) ────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh --cmd cd)"
fi

# ── 15. P10K CONFIG ──────────────────────────────────────────────────────────
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
alias vim="nvim"
alias idea='(nohup /opt/intellij-idea-ultimate-edition/bin/idea . > /dev/null 2>&1 &)'
alias open='xdg-open'
export LIBVIRT_DEFAULT_URI="qemu:///system"

bindkey '^G' autosuggest-accept


export PATH=$PATH:/home/akayxn/.spicetify


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
