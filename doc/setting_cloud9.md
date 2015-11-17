# Cloud9環境構築手順
## WorkSpace作成
1. https://c9.io/
1. GitHubアカウントでログイン
1. Create a new workspaceを選択
1. Clone from Git or Mercurialでhr-dashのSSH clone URLを入力（他は自由）
1. Create workspaceを押下

## リポジトリ変更
1. Cloud9のsshkeyをGitHubの自分のアカウントへ登録
1. sshkeyは~/.sshディレクトリ直下にあります（ない場合はgenしてください）
### Cloud9でworkspaceを作成するとデフォルトリポジトリがmasterになっているのでdevelopへ変更
1. `git checkout develop'
1. `git pull`

## 環境構築
rbenv ruby2.2を用意
1. `gem install bundler`
1. `bundle install --path vendor/bundle`
1. `sudo service postgresql start`
1. `sudo sudo -u postgres psql`
1. `ALTER ROLE postgres with password 'postgres';`
1. `UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';`
1. `DROP DATABASE template1;`
1. `CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';`
1. `UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';`
1. `\c template1`
1. `VACUUM FREEZE;`
1. `\q`
1. `bundle exec rake db:create`
1. `bundle exec rake db:migrate`

##ローカル実行
- `rails server -b $IP -p $PORT`
- コンソール上に出てくるCloud9HelpにサーバーのURLが出力されているのでアクセス
- hr-dashの画面がブラウザで確認できれば終了

##参考
1. https://github.com/Aerogami/guides/wiki/Cloud9-workspace-setup-with-Rails-and-Postgresql
1. https://docs.c9.io/docs/setting-up-postgresql
