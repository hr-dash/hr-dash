# HR Dashのリポジトリーです!!

## 環境構築手順
1. rbenv, ruby2.3を用意
1. `gem install bundler`
1. `git clone git@github.com:hr-dash/hr-dash.git`
1. `cd hr-dash`
1. `bundle install --path vendor/bundle`
1. install postgresql (>= 9.4.0)
  ```
  ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
  ```
  start
  ```
  launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  ```
  stop
  ```
  launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
  ```
1. create postgres user
  `initdb -U postgres -W /usr/local/var/postgres`
  if the directory already exists, remove it before execution.
1. `bundle exec rake db:create`
1. `bundle exec rake db:migrate`
1. `bundle exec rake db:seed`
1. `bundle exec rails s`
1. open http://localhost:3000
1. input test@example.com/password then submit
1. Congratulations!!


### Trouble Shooting
* nokogiriがインストール出来ない場合は、Xcode Command Line Toolsが入っていないかもしれないので、以下のコマンドが役に立つかもしれません。
```
xcode-select --install
```


## コーディング規約
### Ruby
https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md

### Rails
https://github.com/satour/rails-style-guide/blob/master/README-jaJA.md

## Pushする前に...
- `bundle exec rubocop`
- `bundle exec rspec`

完了

