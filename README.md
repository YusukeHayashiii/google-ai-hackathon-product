# 歴史Q&Aチャットボットアプリ

## 目次

- [歴史Q\&Aチャットボットアプリ](#歴史qaチャットボットアプリ)
  - [目次](#目次)
  - [概要](#概要)
  - [主な機能](#主な機能)
  - [技術スタック](#技術スタック)
  - [ディレクトリ構造](#ディレクトリ構造)
  - [ローカルでのセットアップ](#ローカルでのセットアップ)
    - [前提条件](#前提条件)
    - [環境変数](#環境変数)
    - [ローカルでの起動方法](#ローカルでの起動方法)
  - [使用方法](#使用方法)
  - [開発者向け情報](#開発者向け情報)
  - [Cloud Runへのデプロイ](#cloud-runへのデプロイ)
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

## ディレクトリ構造

```
/
├─ deploy
│  ├─ src
│  │  └─ make_agent.py
│  ├─ app.py
│  ├─ Dockerfile
│  └─ requirements.txt
├─ src
│  └─ make_agent.py
├─ .dockerignore
├─ .gitignore
├─ .env.example
├─ app.py
├─ docker-compose.yml
├─ Dockerfile
├─ README.md
└─ requirements.txt
```

- deploy: アプリケーションをCloudRunにデプロイする際のディレクトリ
- src: アプリケーションのソースコード (make_agent.py)
- .dockerignore: Dockerイメージのビルド時に無視するファイルを指定
- .gitignore: Gitリポジトリに追加しないファイルを指定
- .env.example: 環境変数の例
- app.py: Streamlitアプリケーションのメインファイル
- docker-compose.yml: 開発環境のセットアップ
- Dockerfile: アプリケーションのコンテナ化設定
- requirements.txt: Pythonパッケージの依存関係
- README.md: プロジェクトの説明とセットアップ手順

## ローカルでのセットアップ

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
GOOGLE_APPLICATION_CREDENTIALS=your_google_application_credentials_path
```

### ローカルでの起動方法

1. リポジトリをクローンします：

```bash
git clone https://github.com/YusukeHayashiii/google-ai-hackathon-product.git
cd google-ai-hackathon-product
```

2. Docker Composeを使用してアプリケーションを起動します：

```bash
docker-compose up -d
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

## Cloud Runへのデプロイ

- 最初に認証周りを設定します
  - gcloud auth configure-dockerでDockerに対して認証を追加
  - gcloud services enable [artifactregistry.googleapis.com](http://artifactregistry.googleapis.com/)　でArtifact Registryを有効に

- `deploy`ディレクトリに移動します：

```bash
cd deploy
```

- 以下の手順でArtifact Registoryにイメージを追加します

```bash
# イメージをビルド
docker buildx build --platform linux/amd64 -t gcr.io/example/streamlit-app .
# キャッシュなしの場合
docker buildx build --platform linux/amd64 --no-cache -t gcr.io/example/streamlit-app .
# 必要に応じてタグ付け
docker tag [image_id] gcr.io/example/streamlit-app:[tag]

# クラウドにプッシュ(タグを省略するとlatestになる)
docker push gcr.io/example/streamlit-app:[tag]
```

- Cloud Runにデプロイします：

```bash
gcloud run deploy streamlit-app \
  --image gcr.io/praxis-tensor-434514-e6/streamlit-app:[tag] \
  --platform managed \
  --region us-central1 \
  --allow-unauthenticated \
  --timeout 300
```

- デプロイ後に、Cloud RunのURLにアクセスして環境変数を設定します
- 必要に応じて、Cloud Runのサービスアカウントに権限を追加します

## 貢献

プロジェクトへの貢献を歓迎します。問題の報告やプルリクエストは[GitHubリポジトリ](https://github.com/YusukeHayashiii/google-ai-hackathon-product.git)までお願いします。
