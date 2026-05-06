#!/usr/bin/env bash
# Claude Code Status Line
#
# 1 行目: モデル · cwd · git ブランチ
# 2 行目: ctx ▰▱▱▱▱▱▱▱▱▱  6% of 1.0M  ·  5h ▰▱▱▱▱▱▱▱▱▱  7% in 1h7m  ·  7d ▰▱▱▱▱▱▱▱▱▱  5% in 5d7h
#
# - Solarized Light 想定 (16-color ANSI でテーマに乗せる)
# - 残量バーは ▰ (filled) / ▱ (empty) で細身に
# - セパレータは中黒 (·) を薄いグレーで

input=$(cat)

# --- 入力パース ---
model=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // ""')
cwd_display="${cwd/#$HOME/~}"

git_branch=""
if [ -n "$cwd" ] && [ -d "$cwd" ]; then
  git_branch=$(GIT_DIR="$cwd/.git" GIT_WORK_TREE="$cwd" git --no-optional-locks -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
fi

ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_max=$(echo "$input" | jq -r '.context_window.context_window_size // empty')

five_pct=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
five_reset=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // .rate_limits.five_hour.reset_at // empty')
seven_pct=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
seven_reset=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // .rate_limits.seven_day.reset_at // empty')

# --- パレット (Solarized Light 最適化, 16-color ANSI) ---
# Solarized は 16 色を base00-base03 / accent にマップ済み. 256 色で値を直書きせず
# ANSI を使うことでテーマに乗っかる. bright 系 (9x) は Solarized Light で
# それぞれ base01 (92) / base0 (94) / base1 (96) にマップされ, クリーム背景でも
# 視認できる階調になる.
RESET=$'\033[0m'
BOLD=$'\033[1m'

C_MODEL=$'\033[1;34m'     # bold blue   (Solarized blue #268bd2)
C_PATH=$'\033[0;32m'      # green       (Solarized green #859900)
C_GIT=$'\033[0;35m'       # magenta     (Solarized magenta #d33682)

C_LABEL=$'\033[0;92m'     # base01 mid-dark gray (label)
C_MUTED=$'\033[0;94m'     # base0  mid gray      (suffix info)
C_SEP=$'\033[0;96m'       # base1  light gray    (separator)

C_OK=$'\033[0;32m'        # green       低使用率
C_WARN=$'\033[0;33m'      # yellow olive (Solarized #b58900) 中使用率
C_ALERT=$'\033[0;31m'     # red          高使用率

BAR_WIDTH=10
BAR_FILLED='▰'
BAR_EMPTY='▱'
SEP=" ${C_SEP}·${RESET} "

# --- ヘルパー ---

color_for_pct() {
  local v="$1"
  if   [ "$v" -ge 80 ]; then printf '%s' "$C_ALERT"
  elif [ "$v" -ge 50 ]; then printf '%s' "$C_WARN"
  else                       printf '%s' "$C_OK"
  fi
}

make_bar() {
  local pct="$1"
  local int_pct
  int_pct=$(printf "%.0f" "$pct")
  [ "$int_pct" -lt 0 ]   && int_pct=0
  [ "$int_pct" -gt 100 ] && int_pct=100
  local filled=$((int_pct * BAR_WIDTH / 100))
  local empty=$((BAR_WIDTH - filled))
  local bar="" i
  for ((i=0; i<filled; i++)); do bar="${bar}${BAR_FILLED}"; done
  for ((i=0; i<empty;  i++)); do bar="${bar}${BAR_EMPTY}"; done
  printf '%s' "$bar"
}

format_remaining() {
  local resets_at="$1"
  if [ -z "$resets_at" ] || [ "$resets_at" = "null" ]; then return; fi
  local reset_epoch
  if [[ "$resets_at" =~ ^[0-9]+$ ]]; then
    reset_epoch="$resets_at"
  else
    local clean="${resets_at%Z}"
    clean="${clean%+00:00}"
    clean="${clean%%.*}"
    reset_epoch=$(date -j -u -f "%Y-%m-%dT%H:%M:%S" "$clean" "+%s" 2>/dev/null)
  fi
  if [ -z "$reset_epoch" ]; then return; fi
  local now_epoch diff
  now_epoch=$(date "+%s")
  diff=$((reset_epoch - now_epoch))
  if [ "$diff" -le 0 ]; then printf 'soon'; return; fi
  local days=$((diff / 86400))
  local hours=$(((diff % 86400) / 3600))
  local mins=$(((diff % 3600) / 60))
  if   [ "$days"  -gt 0 ]; then printf '%dd%dh' "$days" "$hours"
  elif [ "$hours" -gt 0 ]; then printf '%dh%dm' "$hours" "$mins"
  else                          printf '%dm'    "$mins"
  fi
}

format_tokens() {
  local n="$1"
  if [ -z "$n" ] || [ "$n" = "null" ]; then return; fi
  if   [ "$n" -ge 1000000 ]; then awk -v n="$n" 'BEGIN { printf "%.1fM", n / 1000000 }'
  elif [ "$n" -ge 1000 ];    then awk -v n="$n" 'BEGIN { printf "%dK",   n / 1000 }'
  else                            printf '%d' "$n"
  fi
}

# label  bar  pct  [of <total>]  [in <remaining>]
make_pct_part() {
  local label="$1"
  local pct="$2"
  local resets_at="$3"
  local total="$4"
  if [ -z "$pct" ]; then return; fi
  local v c bar rem
  v=$(printf "%.0f" "$pct")
  c=$(color_for_pct "$v")
  bar=$(make_bar "$pct")
  rem=$(format_remaining "$resets_at")
  printf "${C_LABEL}%s${RESET} ${c}%s${RESET} ${c}${BOLD}%3d%%${RESET}" "$label" "$bar" "$v"
  if [ -n "$total" ]; then
    printf " ${C_MUTED}of %s${RESET}" "$total"
  fi
  if [ -n "$rem" ]; then
    printf " ${C_MUTED}in %s${RESET}" "$rem"
  fi
}

join_with() {
  local sep="$1"; shift
  local first=1 p
  for p in "$@"; do
    if [ "$first" -eq 1 ]; then printf '%s' "$p"; first=0
    else                        printf '%s%s' "$sep" "$p"
    fi
  done
}

# --- 1 行目 ---
line1_parts=()
line1_parts+=("$(printf "${BOLD}${C_MODEL}%s${RESET}" "$model")")
line1_parts+=("$(printf "${C_PATH}%s${RESET}" "$cwd_display")")
if [ -n "$git_branch" ] && [ "$git_branch" != "HEAD" ]; then
  line1_parts+=("$(printf "${C_GIT}⎇ %s${RESET}" "$git_branch")")
fi

# --- 2 行目 ---
line2_parts=()
if [ -n "$ctx_pct" ]; then
  ctx_max_display=$(format_tokens "$ctx_max")
  line2_parts+=("$(make_pct_part "ctx" "$ctx_pct" "" "$ctx_max_display")")
fi
if [ -n "$five_pct" ]; then
  line2_parts+=("$(make_pct_part "5h" "$five_pct" "$five_reset" "")")
fi
if [ -n "$seven_pct" ]; then
  line2_parts+=("$(make_pct_part "7d" "$seven_pct" "$seven_reset" "")")
fi

# --- 出力 ---
line1=$(join_with "$SEP" "${line1_parts[@]}")
if [ ${#line2_parts[@]} -gt 0 ]; then
  line2=$(join_with "$SEP" "${line2_parts[@]}")
  printf '%s\n%s' "$line1" "$line2"
else
  printf '%s' "$line1"
fi
