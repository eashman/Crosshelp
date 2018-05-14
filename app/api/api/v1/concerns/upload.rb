# -*- coding: utf-8 -*-
module API
  module V1
    module Concerns
      module Upload
        extend ActiveSupport::Concern
        included do
          desc '上传阿里云oss [POST /upload/oss]'
          params do
            requires :file, type: File, desc: '文件'
          end
          post '/upload/oss' do
            file = params.file
            tmpfile = file.tempfile
            object_key = SecureRandom.hex(16)
            name = "#{object_key+file.filename}"
            result = Utils::Uploader.bucket.put_object(name, file: tmpfile,content_type: file.type)
            if result
             wrap_meta(name: name)
           else
             wrap_meta(msg: '上传异常')
           end
          end

          desc '下载阿里云oss [GET /upload/load]'
          params do
            requires :name, type: String, desc: '文件名'
          end
          get '/upload/load' do
            result = Utils::Uploader.bucket.object_url(params.name,true,3600)
            wrap_meta(url: result)
          end
        end
      end
    end
  end
end
