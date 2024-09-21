# ベースイメージの指定
FROM python:3.12-slim

# システムパッケージのアップデート
RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
    git \
    curl \
    fonts-ipaexfont \
    fonts-noto-cjk \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# Google Cloud CLIのインストール
RUN curl -sSL https://sdk.cloud.google.com | bash
ENV PATH $PATH:/root/google-cloud-sdk/bin

# 作業ディレクトリの設定
WORKDIR /app

# 必要なファイルをコピー
COPY requirements.txt .
COPY app.py .
COPY src/ ./src/
# 開発環境用の.envファイルをコピー（本番環境では不要）
COPY .env .env

# Pythonライブラリのインストール
RUN pip install --no-cache-dir -r requirements.txt

# gcloudの設定ディレクトリを作成
RUN mkdir -p /root/.config/gcloud

# 認証情報をコピー
# COPY application_default_credentials.json /root/.config/gcloud/

# ポートの公開（Cloud Runでは8080）
EXPOSE 8080

# Streamlitアプリの起動（Cloud Runでは8080）
ENTRYPOINT ["streamlit", "run"]
CMD ["app.py", "--server.port=8080", "--server.address=0.0.0.0"]