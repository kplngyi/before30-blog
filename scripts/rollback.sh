#!/usr/bin/env bash

set -euo pipefail

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "当前目录不是 Git 仓库。"
  exit 1
fi

if [[ -n "$(git status --short)" ]]; then
  echo "当前有未提交改动，请先提交或清理工作区后再回退。"
  exit 1
fi

target="${1:-HEAD}"

if ! git rev-parse --verify "$target" >/dev/null 2>&1; then
  echo "找不到提交：$target"
  exit 1
fi

echo "准备回退提交：$(git rev-parse --short "$target")"
git log -1 --oneline "$target"

git revert --no-edit "$target"
git push

echo "已完成回退并推送到远程仓库。"
