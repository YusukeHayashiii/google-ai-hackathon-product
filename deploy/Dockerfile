# 参考： https://zenn.dev/ncdc/articles/71d49bced3b69d
# ベースイメージの指定
FROM python:3.12-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# システムパッケージのアップデート
RUN apt-get update

# 作業ディレクトリの設定
WORKDIR /app

# 必要なファイルをコピー
COPY requirements.txt .
COPY app.py .
COPY src/ ./src/

# Pythonライブラリのインストール
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# ポートの公開（Cloud Runでは8080）
EXPOSE 8080

# Streamlitアプリの起動
CMD ["streamlit", "run", "app.py", "--server.port", "8080"]