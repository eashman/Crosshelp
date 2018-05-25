# frozen_string_literal: true

# 加载oss 库 初始化连接参数
require 'aliyun/oss'
module Utils
  class Uploader
    def self.client
      @client = Aliyun::OSS::Client.new(
        endpoint: Settings.aliyun.endpoint,
        access_key_id: Settings.aliyun.access_key_id,
        access_key_secret: Settings.aliyun.access_key_secret
      )
      @client
    end

    def self.bucket
      @bucket = Utils::Uploader.client.get_bucket(Settings.aliyun.bucket)
    end

    def self.pubbucket
      @bucket = Utils::Uploader.client.get_bucket(Settings.aliyun.pubbucket)
    end
  end
end
