#!/usr/bin/env bash
# setup_github.sh
# go-no-sen リポジトリを GitHub に一発セットアップするスクリプト
#
# 前提条件:
#   - git がインストール済み
#   - GitHub CLI (gh) がインストール済み: https://cli.github.com/
#   - gh auth login 済み (gh auth status で確認)
#
# 使い方 (WSL / Linux):
#   1. go-no-sen/ フォルダに cd する
#      例: cd /mnt/c/Users/keita/go-no-sen
#   2. chmod +x setup_github.sh
#   3. ./setup_github.sh

set -euo pipefail

REPO="keith-river/go-no-sen"
DESCRIPTION="後の先：捕食者・被食者シミュレーション × 強化学習 — 自然界の攻防から地域ビジネスの生存戦略を考える"
HOMEPAGE="https://keith-river.github.io/go-no-sen/"

echo ""
echo "========================================"
echo "  go-no-sen GitHub セットアップ"
echo "========================================"
echo ""

# --- 1. Git 初期化 ---
echo "[1/5] git init & 初回コミット..."

if [ ! -d ".git" ]; then
  git init
  git branch -M main
fi

git add .
git commit -m "feat: 後の先シミュレーション initial release

- Stage 1: チーター vs インパラ (Reynolds操舵・ヒューリスティック)
- Stage 2/3: チーター (Q学習→DQN) vs インパラ (後の先メトリクス)
- Stage 3 Aerial: ハチドリ vs トンボ (双方向DQN・3D空中戦・共進化)
- docs/ GitHub Pages 対応ランディングページ"

echo "  -> コミット完了"

# --- 2. GitHub リポジトリ作成 ---
echo ""
echo "[2/5] GitHub リポジトリ作成: ${REPO} ..."

gh repo create "${REPO}" \
  --public \
  --description "${DESCRIPTION}" \
  --homepage "${HOMEPAGE}"

echo "  -> リポジトリ作成完了"

# --- 3. remote 設定 & push ---
echo ""
echo "[3/5] remote 設定 & push..."

git remote add origin "https://github.com/${REPO}.git"
git push -u origin main

echo "  -> push 完了"

# --- 4. GitHub Pages 有効化 (docs/ ディレクトリ) ---
echo ""
echo "[4/5] GitHub Pages 有効化 (branch: main, path: /docs)..."

gh api \
  -X PUT \
  "/repos/${REPO}/pages" \
  -f build_type=legacy \
  -f source.branch=main \
  -f source.path=/docs

echo "  -> GitHub Pages 有効化完了"

# --- 5. 完了 ---
echo ""
echo "========================================"
echo "  セットアップ完了！"
echo "========================================"
echo ""
echo "GitHub リポジトリ : https://github.com/${REPO}"
echo "GitHub Pages     : ${HOMEPAGE}"
echo ""
echo "※ GitHub Pages の反映には数分かかる場合があります。"
echo "  反映後、上記 URL をブラウザで開いてください。"
echo ""
