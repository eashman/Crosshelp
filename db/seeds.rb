# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Administrator.create(email: 'admin@kuangjinghelp.com', password: '123456')

TAGE = '公司整体战略,企业管理,AMAZON运营,EBAY运营,速卖通运营,WISH运营,亚马逊选品,产品开发,人力资源管理,招聘管理,采购运营管理,黑科技,大数据分析,站外引流,物流渠道开发管理,SEO/SEM,ERP系统开发运营,网络技术架构设计,行政管理,FB/Google推广,VAT,财务管理及规划,客服沟通,跨境支付,知识产权,绩效考核制度设计,商标专利,销售管理,美工设计,仓储管理,摄影摄像,工业设计,软件开发'
TAGE.split(',').each_with_index do |item, index|
  Label.create(tag: item, sort: index)
end

JOB = '跨境电商,服务商,产品供应商'
JOB.split(',').each_with_index do |item, index|
  Job.create(name: item, sort: index, level: 1)
end

NAMES = '赵钱孙李周吴郑王'
def telephone
  "136#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}#{rand(10)}"
end

def random_word(num)
  NAMES.split('').sample(num).join('')
end

10.times do |_i|
  User.create!(
    name: random_word(3),
    phone: telephone
  )
end
