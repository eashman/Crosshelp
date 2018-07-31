做的远程的项目，公司没有给一分钱，现在项目就开源
* Server

** 构建开发环境
*** 外部依赖

目前用的：

- =ruby@2.5.0=
- =postgresql@9.5=
- =redis@3.2.3=
- =elasticsearch@2.3.5=

未来有可能用的：

- =memcached=

*** 初始化

#+BEGIN_SRC shell
$ docker-compose up -d
$ gem install bundler
$ bundle install
$ rails db:setup
$ rails spec





