# frozen_string_literal: true

require 'rong_cloud'

RongCloud.configure do |config|
  config.app_key = Settings.rongcloud.app_key
  config.app_secret = Settings.rongcloud.app_secret
  # config.host = "http://api.cn.ronghub.com"   # default: https://api.cn.ronghub.com, use http here is just convenient for debugging
  # config.timeout = 10 # set open timeout and read timeout in seconds for http request, default is 2 seconds
  # config.debug_mode = true # if need to log request and response details, the log file is at "log/rong_cloud_debug.log", default is `false`
end
