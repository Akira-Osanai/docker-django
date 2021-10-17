FROM python:3
# .pyc を生成しない
# 標準出力・標準エラーのストリームのバッファリングを行わない
# インタプリタの UTF-8 モードを有効にする
# pip 自体のバージョンチェックを何度も行うのを防ぐ
# truthy な値か falsy な値ならキャッシュを生成しない
ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PYTHONUTF8=1 \
  PIP_NO_CACHE_DIR=off \
  PIP_DISABLE_PIP_VERSION_CHECK=on
# mkdir /code を実行
RUN mkdir /code
# 作業ディレクトリを code に設定。
WORKDIR /code
# ローカルのrequirements.txt を コンテナ上の codeの中に追加する。
ADD requirements.txt /code/
# コマンドの実行
RUN pip install -r requirements.txt
# ローカルのdocker-djangoディレクトリの中身を コンテナのcodeの中に追加する。
ADD . /code/