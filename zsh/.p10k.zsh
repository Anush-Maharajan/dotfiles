# ~/.p10k.zsh — Best-looking single-line prompt, no user@host
# Layout:  ~/path  main *2 !1                          12:04  took 3s ❯

'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  [[ $ZSH_VERSION == (5.<1->*|<6->.*) ]] || return

  # ── Palette — soft, high-contrast, easy on the eyes (Tokyo Night-ish) ───
  local grey='#565f89'
  local red='#f7768e'
  local green='#9ece6a'
  local yellow='#e0af68'
  local blue='#7aa2f7'
  local cyan='#7dcfff'
  local magenta='#bb9af7'

  # ── ONE line, no context/username ────────────────────────────────────
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir
    vcs
    prompt_char
  )
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    background_jobs
  )

  # ── Core style ────────────────────────────────────────────────────────
  typeset -g POWERLEVEL9K_MODE=nerdfont-v3
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_BACKGROUND=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=
  typeset -g POWERLEVEL9K_SHOW_RULER=false
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  # ── Directory — the visual anchor of the prompt ─────────────────────────
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=$blue
  typeset -g POWERLEVEL9K_DIR_ANCHOR_FOREGROUND=$cyan
  typeset -g POWERLEVEL9K_DIR_ANCHOR_BOLD=true
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=
  typeset -g POWERLEVEL9K_DIR_MAX_LENGTH=48
  typeset -g POWERLEVEL9K_DIR_MIN_COMMAND_COLUMNS=40
  typeset -g POWERLEVEL9K_DIR_HYPERLINK=false

  # ── Git — clean colored branch + counts, capped for perf ────────────────
  typeset -g POWERLEVEL9K_VCS_MAX_INDEX_SIZE_DIRTY=3000
  typeset -g POWERLEVEL9K_VCS_BACKENDS=(git)
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON='\uF126 '
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=$green
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=$grey
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_ICON='?'
  typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
  typeset -g POWERLEVEL9K_VCS_STAGED_ICON='+'
  typeset -g POWERLEVEL9K_VCS_UNSTAGED_ICON='!'
  typeset -g POWERLEVEL9K_VCS_DISABLED_WORKDIR_PATTERN='~'

  # ── Prompt char — the "pulse" of the prompt, green/red on success/fail ──
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$magenta
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=$red
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=true
  typeset -g POWERLEVEL9K_PROMPT_CHAR_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=' '

  # ── Status / exec time / bg jobs — quiet unless something's noteworthy ──
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=$red
  typeset -g POWERLEVEL9K_STATUS_ERROR_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL_FOREGROUND=$red

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=1
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$yellow
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'

  typeset -g POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND=$cyan

  # ── Clock — small, muted, top-right anchor for at-a-glance time ─────────
  typeset -g POWERLEVEL9K_TIME_FOREGROUND=$grey
  typeset -g POWERLEVEL9K_TIME_FORMAT='%D{%H:%M}'
  typeset -g POWERLEVEL9K_TIME_UPDATE_ON_COMMAND=false

  # ── Transient prompt — old lines collapse to just ❯, keeps history tidy ─
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=always

  # ── Instant prompt — fastest possible shell startup ──────────────────────
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
