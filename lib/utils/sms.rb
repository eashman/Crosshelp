#加载oss 库 初始化连接参数
require "net/http"
require "open-uri"
require "uri"
require 'digest/sha1'
module Utils
  class Sms
    def self.httpPost(data, uri, appKey, secret, apiType)
    	nonce = rand(1000000).to_s
    	timestamp = (Time.now.to_i).to_s
    	shastr = secret + nonce + timestamp
    	signature = Digest::SHA1.hexdigest(shastr)
    	if apiType == "API"
     	uri = URI.parse("http://api.cn.ronghub.com#{uri}")
     	elsif apiType == "SMS"
     	uri = URI.parse("http://api.sms.ronghub.com#{uri}")
     	end
     	http = Net::HTTP.new(uri.host, uri.port)
    	request = Net::HTTP::Post.new(uri.request_uri,"RC-App-Key"=>appKey ,"RC-Nonce" =>nonce, "RC-Timestamp"=>timestamp, "RC-Signature"=>signature,'Content-Type' => 'application/x-www-form-urlencoded')
    	request.set_form_data(data)
    	response = http.request(request)
    	return response.body
    	rescue => e
        puts "failed #{e}"
      end
    def self.sendCode(mobile,templateId,region,verifyId=nil,verifyCode=nil)
      @appKey = Settings.rongcloud.app_key
      @secret = Settings.rongcloud.app_secret
  		if mobile.nil?
  			raise ArgumentError, ('Paramer "mobile" is required');
  		end

  		if templateId.nil?
  			raise ArgumentError, ('Paramer "templateId" is required');
  		end

  		if region.nil?
  			raise ArgumentError, ('Paramer "region" is required');
  		end

  		data = Hash.new
  		if !mobile.nil?
  			data ["mobile"] = mobile
  		end

  		if !templateId.nil?
  			data ["templateId"] = templateId
  		end

  		if !region.nil?
  			data ["region"] = region
  		end

  		data ["verifyId"] = verifyId
  		data ["verifyCode"] = verifyCode

  		uri = "/sendCode.json"

  		return Utils::Sms.httpPost data,uri,@appKey,@secret,"SMS"
	  end
  end
end
