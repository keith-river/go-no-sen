# 後の先（Go-no-sen）— 捕食者・被食者シミュレーション × 強化学習

> 自然界の攻防戦から地域ビジネスの生存戦略を考える

**GitHub Pages デモ**: https://keith-river.github.io/go-no-sen/

---

## 概要

剣道・居合道でいう「**後の先（ごのせん）**」——相手が先に動いた後、コミットした軌跡を読んで確実に反撃する戦略——が、強化学習エージェントの学習過程で**自発的に出現するかどうか**を検証するシミュレーションです。

すべてThree.js（WebGL）ベースのブラウザSPAで、インストール不要で動作します。

---

## シミュレーション一覧

| ステージ | ファイル | 内容 |
|---|---|---|
| Stage 1 | `docs/stage1.html` | チーター vs インパラ（Reynolds操舵・ヒューリスティック本能行動） |
| Stage 2/3 | `docs/stage2.html` | チーター（Q学習→DQN強化学習） vs インパラ（本能） |
| Stage 3 Aerial | `docs/stage3.html` | ハチドリ vs トンボ（双方向DQN・3D空中戦・共進化） |

---

## 動かし方

```bash
git clone https://github.com/keith-river/go-no-sen.git
cd go-no-sen/docs
# 任意のHTMLファイルをブラウザで開く（Webサーバー不要）
```

---

## 技術スタック

- **Three.js r128** — 3D描画（WebGL）
- **バニラJS** — 強化学習エンジン（DQN, Q-table）、外部MLライブラリ不使用
- **Reynolds操舵** — seek / flee / pursuit / evasion / wander
- **DQN実装** — 2層MLP (10→48→25)、Adamオプティマイザ、リプレイバッファ(6000)、ターゲットネットワーク
- **共進化** — 双方がDQN学習する非定常環境（Stage 3）

---

## 「後の先」とは

```
先の先 = こちらが先に動く（リスクは高いが先手）
後の先 = 相手が動いた後、確定した軌跡を読んで仕掛ける（確実性が高い）
先々の先 = 相手が動く前から意図を読んで先手（最高難度）
```

Stage 2/3のチーター（DQN）が学習を積むと、インパラの**方向転換直後（コミットした瞬間）**に仕掛けるパターンが高いQ値を持つようになります。これを「後の先の自発的学習」として可視化しています。

---

## ファイル構成

```
go-no-sen/
├── README.md
├── LICENSE
├── .gitignore
├── article.md          # Qiita Advent Calendar 記事原稿
├── setup_github.ps1    # gh repo create + GitHub Pages 有効化スクリプト
└── docs/               # GitHub Pages 公開ディレクトリ
    ├── index.html      # ランディングページ
    ├── stage1.html     # チーター vs インパラ（本能）
    ├── stage2.html     # チーター（DQN） vs インパラ
    └── stage3.html     # ハチドリ vs トンボ（3D空中戦）
```

---

## 関連記事

- Qiita Advent Calendar 2026: https://qiita.com/advent-calendar/2026/turtle-walkers
- 記事原稿（このリポジトリ）: `article.md`

---

## ライセンス

MIT License — 詳細は `LICENSE` を参照

---

*Author: keithrive / keitaro.horikawa@gmail.com*
