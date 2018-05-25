# frozen_string_literal: true

# 加载oss 库 初始化连接参数
require 'net/http'
require 'open-uri'
require 'uri'
require 'digest/sha1'
module Utils
  class Sms
    def self.httpPost(data, uri, appKey, secret, apiType)
      nonce = rand(1_000_000).to_s
      timestamp = Time.now.to_i.to_s
      shastr = secret + nonce + timestamp
      signature = Digest::SHA1.hexdigest(shastr)
      if apiType == 'API'
        uri = URI.parse("http://api.cn.ronghub.com#{uri}")
      elsif apiType == 'SMS'
        uri = URI.parse("http://api.sms.ronghub.com#{uri}")
       end
      http = Net::HTTP.new(uri.host, uri.port)
      request = Net::HTTP::Post.new(uri.request_uri, 'RC-App-Key' => appKey, 'RC-Nonce' => nonce, 'RC-Timestamp' => timestamp, 'RC-Signature' => signature, 'Content-Type' => 'application/x-www-form-urlencoded')
      request.set_form_data(data)
      response = http.request(request)
      response.body
      rescue StandardError => e
        puts "failed #{e}"
      end

    def self.sendCode(mobile, templateId, region, code)
      @appKey = Settings.rongcloud.app_key
      @secret = Settings.rongcloud.app_secret
      raise ArgumentError.new('Paramer "mobile" is required') if mobile.nil?

      raise ArgumentError.new('Paramer "templateId" is required') if templateId.nil?

      raise ArgumentError.new('Paramer "region" is required') if region.nil?

      raise ArgumentError.new('Paramer "code" is required') if code.nil?

      data = {}
      data ['mobile'] = mobile unless mobile.nil?

      data ['templateId'] = templateId unless templateId.nil?

      data ['region'] = region unless region.nil?

      data ['p1'] = code unless code.nil?

      uri = '/sendNotify.json'

      Utils::Sms.httpPost data, uri, @appKey, @secret, 'SMS'
    end
  end
end
