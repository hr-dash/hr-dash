# Cloud9環境構築手順
## WorkSpace作成
1. https://c9.io/
2. GitHubアカウントでログイン
3. Create a new workspaceを選択
4. Clone from Git or Mercurialでhr-dashのSSH clone URLを入力（他は自由）
5. Create workspaceを押下

## リポジトリ変更
1. Cloud9のsshkeyをGitHubの自分のアカウントへ登録
2. sshkeyは~/.sshディレクトリ直下にあります（ない場合はgenしてください)
3. Cloud9でworkspaceを作成するとデフォルトリポジトリがmasterになっているのでdevelopへ変更
4. `git checkout develop`
5. `git pull`

## 環境構築
1. rbenv ruby2.2を用意
2. `gem install bundler`
3. `bundle install --path vendor/bundle`
4. `sudo service postgresql start`
5. `sudo sudo -u postgres psql`
6. `ALTER ROLE postgres with password 'postgres';`
7. `UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';`
8. `DROP DATABASE template1;`
9. `CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';`
10. `UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';`
11. `\c template1`
12. `VACUUM FREEZE;`
13. `\q`
14. `bundle exec rake db:create`
15. `bundle exec rake db:migrate`

##ローカル実行
- `rails server -b $IP -p $PORT`
- コンソール上に出てくるCloud9HelpにサーバーのURLが出力されているのでアクセス
- hr-dashの画面がブラウザで確認できれば終了

##参考
1. https://github.com/Aerogami/guides/wiki/Cloud9-workspace-setup-with-Rails-and-Postgresql
2. https://docs.c9.io/docs/setting-up-postgresql
