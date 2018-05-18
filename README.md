#+OPTIONS: toc:2

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
#+END_SRC

#+BEGIN_QUOTE
- 若 =db:setup= 时出错，查看 =config/database.yml= 中 =development= 环境的有关设置。
- 若 =gem install pg= 出错，请临时在宿主机里安装一个 =postgresql= ，目前没什么好的解决办法（
#+END_QUOTE

#+BEGIN_QUOTE
尽量让你的环境符合该配置，而不是更改配置文件，因为它在VCS内，你方便了别人就不方便了。
#+END_QUOTE

** 代码风格

- Two spaces
- 代码块多于一行时不要使用花括号，用 =do...end=
- 仅在展示「给人看的字符串」时使用 =String= ，其余时候使用 =Symbol= 。
    - =Symbol= 有几个特性，但唯独"它的字面量是什么"是不重要的。
    - 对 =String= ，能使用单引号的就不要使用双引号。
- 省略方法参数的括号，在不引起歧义和不影响阅读速度的前提下。
    - 比如，使用 Rails DSL 时可以省略，调用自定义方法时最好不要省略。
- 若可以使用 =&:method_name= 语法糖，使用它。

#+BEGIN_QUOTE
考虑如下代码：
#+BEGIN_SRC ruby
user_ids = users.map do |user|
  user.id
end
#+END_SRC
其可以简写为
#+BEGIN_SRC ruby
user_ids = users.map(&:id)
# 其实这里用 users.pluck(:id) 才是合理做法…
#+END_SRC
#+END_QUOTE

** 指导思想
- 不要手动配置些什么，除非你有充分的理由。
    - aka「约定优于配置」 (convention over configuration)。
- Fat model, skinny controller.
    - Controller 不能太重，把业务逻辑放到 =Model= 的method里。这样别的地方也有机会复用。
    - 也不用太死板，灵活机动也是很重要的。实在有必要，写段comment向一个月后的自己解释一下。

** 提交指引


#+BEGIN_QUOTE
我不是英语母语使用者，他们规定的「动宾短语」型 commit message 我看得累。
所以我自己发明了一套 commit message 格式，用符号代替动词。

- =[+]= :: Add new features
    - =[++]= :: Add much more new features
- =[-]= :: Remove features
- =[!]= :: Fix a Bug, or just a modification.
    - =[!!]= :: Fix a typo
- =[#]= :: Implement a feature

另外针对一些非业务代码：

- =[SPEC]= :: 测试用例修改
- =[DOC]= :: 文档修改

使用例：
- =[+] POST /users/login=
- =[!!] Project.user_list=
- =[!][DOC] POST /users/profile=
- =[!!][SPEC] DatabaseCleaner config=
#+END_QUOTE
