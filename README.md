# HR Dashのリポジトリーです!!
ci-test

tezuka書き込み
sawada書き込み
kubota書き込み
ohara!!
kudo書き込み
yamazaki書き込み


# 環境構築手順
1. rbenv, ruby2.2を用意
2. `gem install bundler`
3. `git clone http://XXXXXXXXXXXXX/gitbucket/git/hiroyuki.izuya/hr-dash.git`
4. `cd hr-dash`
5. `bundle install --path vendor/bundle`
6. `bundle exec rake db:create`
7. `bundle exec rake db:migrate`

# コーディング規約
## Ruby
https://github.com/fortissimo1997/ruby-style-guide/blob/japanese/README.ja.md

## Rails
https://github.com/satour/rails-style-guide/blob/master/README-jaJA.md

# Pushする前に...
- `bundle exec rubocop`
- `bundle exec rspec`

完了

