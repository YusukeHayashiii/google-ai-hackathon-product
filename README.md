# 歴史Q&Aチャットボットアプリ

## 目次

- [歴史Q\&Aチャットボットアプリ](#歴史qaチャットボットアプリ)
  - [目次](#目次)
  - [概要](#概要)
  - [主な機能](#主な機能)
  - [技術スタック](#技術スタック)
  - [セットアップ](#セットアップ)
    - [前提条件](#前提条件)
    - [環境変数](#環境変数)
    - [起動方法](#起動方法)
  - [使用方法](#使用方法)
  - [開発者向け情報](#開発者向け情報)
  - [ライセンス](#ライセンス)
  - [貢献](#貢献)

## 概要

このプロジェクトは、織田信長、豊臣秀吉、徳川家康、明智光秀について詳しく回答できる歴史Q&Aチャットボットを実装したStreamlitアプリケーションです。Google VertexAI、Neo4jグラフデータベース、およびLangChainを使用して構築されています。

## 主な機能

- 日本の戦国時代の主要な歴史上の人物に関する質問に答えるチャットインターフェース
- ベクトル検索とグラフデータベースクエリを組み合わせた高度な回答生成
- Streamlitを使用したユーザーフレンドリーなWebインターフェース

## 技術スタック

- Python 3.12
- Streamlit
- LangChain
- Google VertexAI (Gemini 1.5 Pro)
- Neo4j
- Docker

## セットアップ

### 前提条件

- Dockerがインストールされていること
- Google Cloud Platformのアカウントとプロジェクトが設定されていること
- Neo4jデータベース（AuraまたはセルフホスティングDB）が用意されていること

### 環境変数

以下の環境変数を`.env`ファイルに設定してください：
```
COMPOSE_PROJECT_NAME=your_project_name
PORT=your_port_number
NEO4J_URI=your_neo4j_uri
NEO4J_USERNAME=your_neo4j_username
NEO4J_PASSWORD=your_neo4j_password
AURA_INSTANCEID=your_aura_instanceid
AURA_INSTANCENAME=your_aura_instancename
PROJECT_ID=your_project_id
REGION=your_region
STAGING_BUCKET=your_staging_bucket
```

### 起動方法

1. リポジトリをクローンします：

```bash
git clone https://github.com/YusukeHayashiii/google-ai-hackathon-product.git
cd google-ai-hackathon-product
```

2. Docker Composeを使用してアプリケーションを起動します：

```bash
docker-compose up --build
```

3. ブラウザで `http://localhost:8080` にアクセスしてアプリケーションを使用します。

## 使用方法

- チャットインターフェースに質問を入力します。
- AIアシスタントが日本の歴史、特に織田信長、豊臣秀吉、徳川家康、明智光秀に関する質問に答えます。
- サイドバーの「チャット履歴をリセット」ボタンを使用して、会話をクリアできます。

## 開発者向け情報

- `app.py`: Streamlitアプリケーションのメインファイル
- `make_agent.py`: AIエージェントとツールのセットアップロジック
- `Dockerfile`: アプリケーションのコンテナ化設定
- `docker-compose.yml`: 開発環境のセットアップ

## ライセンス

このプロジェクトは[ライセンス名]の下で公開されています。詳細については`LICENSE`ファイルを参照してください。

## 貢献

プロジェクトへの貢献を歓迎します。問題の報告やプルリクエストは[GitHubリポジトリ](https://github.com/YusukeHayashiii/google-ai-hackathon-product.git)までお願いします。
