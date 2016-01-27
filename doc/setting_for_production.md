# Productionで起動するためのメモ

ローカルPCで`RAILS_ENV=production`で動かした時のメモ

### 【環境変数の設定】
- config/database.ymlでproductionの箇所を埋めよう（developmentと同じ値で良い）
- config/secrets.ymlでproductionの箇所を埋めよう（rake secretで出力可）

### 【DBの設定】

```
RAILS_ENV=production bundle exec rake db:create
RAILS_ENV=production bundle exec rake db:migrate
RAILS_ENV=production bundle exec rake db:seed
```

### 【nginxの設定】

```
brew install nginx
```

confファイルをいじる
自分は`/usr/local/etc/nginx/nginx.conf`だったけど無ければ何とか探す

```
httpディレクティブの中のserverディレクティブに以下を追加
元々serverディレクティブとかあったら一旦コメントアウト
Pathはよしなにする

upstream unicorn {
  # unicorn.rbで設定したunicorn.sockを指定
  server unix:/Users/bakunyo/workspace/hr-dash/tmp/production_unicorn.sock;
}

server {
  listen 8080;
  server_name hr-dash;
  root /Users/bakunyo/workspace/hr-dash/public;
  access_log /Users/bakunyo/workspace/hr-dash/log/nginx_access.log;
  error_log /Users/bakunyo/workspace/hr-dash/log/nginx_error.log;
  try_files $uri/index.html $uri @unicorn;
  location @unicorn {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_pass http://unicorn;
  }
}
```

起動

```
nginx
```

### 【アセットコンパイル】

```
RAILS_ENV=production bundle exec rake assets:precompile
```

### 【サーバー起動】

```
bundle exec unicorn_rails -c config/unicorn.rb -E production
```

完

