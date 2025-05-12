# HibiLog（ひびログ）

<img width="500" src="app/assets/images/ogp.png"><br>

---

# 目次

- [サービス概要](#-サービス概要)
- [サービス URL](#-サービスurl)
- [開発の背景](#-開発の背景)
- [機能紹介](#-機能紹介)
- [技術構成について](#-技術構成について)
  - [使用技術](#使用技術)
  - [ER 図](#er図)
  - [画面遷移図](#画面遷移図)<br>

---

# 🌍 サービス概要

HibiLog は、短文の日記や感じたことを機能的に投稿できる Web 日記アプリです。<br>
日記をエッセイや日常の記録として簡単に書けるだけでなく、コメントやイイねなどの SNS 的な要素も含み、他人とも絡めることができる設計にしました。

---

# 🌐 サービス URL

https://hibilog.com

---

# 📖 開発の背景

プログラミングスクールに通い始めたことをきっかけに、日々の学習や日常を記録する日記習慣ができました。その中で、成長や気持ちの変化に気づける経験がひとつの実りとなり、この体験を他の人にも届けたいという思いから、このアプリを開発しました。

---

# 💻 機能紹介

- ユーザー登録/ログイン (メール+Google OAuth)
- 日記投稿 (タイトル+本文+Markdown)
- 画像投稿 / 表示
- コメント機能
- いいね / ブックマーク
- 検索機能 (キーワード)
- 一覧の並び替え機能 (新着順 / ランダム)
- 公開設定 (公開/非公開)
- 日記投稿日をカレンダー表示 (simple_calendar)

---

# 🔧 技術構成について

## 使用技術

| カテゴリ       | 内容                                 |
| -------------- | ------------------------------------ |
| サーバーサイド | Ruby on Rails 8 / Ruby 3.2           |
| フロントエンド | Tailwind CSS / Stimulus / JavaScript |
| バックエンド   | PostgreSQL                           |
| テスト         | RSpec / FactoryBot                   |
| 診断 / CI      | RuboCop / Brakeman / GitHub Actions  |
| ログイン       | Sorcery / Google OAuth2              |
| デプロイ       | Render / Docker / GitHub Actions     |

## ER 図

[ER 図 - Gyazo](https://gyazo.com/1e2dac8144b05b81d4129e53ffdf1000)

## 画面遷移図

[Figma 画面遷移図](https://www.figma.com/design/uCwxo2gTmsbj3ZzZxnH5O6/Diary-Application?node-id=0-1&t=eDly5tGJKtBEKPuJ-1)

---

# 🔮 今後の拡張予定

- 「1 年前の今日の投稿」を表示する振り返り機能
- SNS 連携を通じた発信機能

---
