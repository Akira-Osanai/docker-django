# はじめに

DockerでDjangoを使ってます。  

## 構成

- Docker
- Django3.2
- postgresql

## 初期設定

1. .envファイルを作成する。

```text
# DB 接続情報
DB_HOST=db  #dockerのコンテナ名なので固定
DB_PORT=ポート番号（5432）
DB_NAME=データベース名
DB_USER=ログインユーザー名
DB_PASSWORD=ログインパスワード

# タイムゾーンの設定
TZ=Asia/Tokyo
```

2. プロジェクトの作成を行う。

```Bash
cd このディレクトリ
docker-compose run web django-admin startproject config .
```

## 起動するとき

1. コンテナの起動を行う。

```Bash
docker-compose up -d
```

## 終了するとき

1. コンテナを停止させる。

```Bash
docker-compose down
```

## アプリを作成するとき

1. コマンドを実行する。

```Bash
docker-compose run web python manage.py startapp helloworld
```

2. settings.pyに追記。

```Django
INSTALLED_APPS = [
  'django.contrib.admin',
  'django.contrib.auth',
  'django.contrib.contenttypes',
  'django.contrib.sessions',
  'django.contrib.messages',
  'django.contrib.staticfiles',
  #追加
  'helloworld',
]
```

```Django
TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        #追加
        'DIRS': [BASE_DIR, 'templates'],
        #ここまで
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]
```

project/urls.py

```Django
from django.contrib import admin
from django.urls import path, include  # includeを忘れずにインポート

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('helloworld.urls')), # アプリのurls.pyを参照
]
```

コマンド

```Bash
cd helloworld
vi urls.py
```

helloworld/urls.py

```Django
from django.urls import path
from . import views # 同じ階層内のviews.pyを読み込んでる

app_name = 'helloworld'
urlpatterns = [
  path('', views.index, name='index') # URLに何も付いてなければviews.pyのindex関数を実行する
]
```

helloworld/views.py

```Django
from django.shortcuts import render

def index(request):
  return render(request, 'helloworld/index.html')
```

コマンド

```Bash
mkdir -pv templates/helloworld
vi templates/helloworld/index.html
```

templates/helloworld/index.html

```HTML
<h1>Hello World!</h1>
```



## 技術的な話

此処から先は読まなくても大丈夫です。

### .gitignore作成

.gitignoreは以下のサイトで作成しました。

[gitignore.io](https://www.toptal.com/developers/gitignore)
