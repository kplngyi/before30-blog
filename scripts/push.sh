#!/usr/bin/env bash

set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "当前目录不是 Git 仓库。"
  exit 1
fi

if [[ -n "$(git status --short)" ]]; then
  message="${1:-}"

  if [[ -z "$message" ]]; then
    message="chore: update blog $(date '+%Y-%m-%d %H:%M:%S')"
  fi

  git add .
  git commit -m "$message"
  git push

  echo "已提交并推送到远程仓库。"
else
  echo "没有可提交的改动。"
fi
