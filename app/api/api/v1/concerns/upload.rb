# frozen_string_literal: true

module API
  module V1
    module Concerns
      module Upload
        extend ActiveSupport::Concern
        included do
          desc '上传私有阿里云oss [POST /upload/oss]'
          params do
            requires :file, type: File, desc: '文件'
          end
          post '/upload/oss' do
            file = params.file
            tmpfile = file.tempfile
            object_key = SecureRandom.hex(16)
            name = (object_key + file.filename).to_s
            result = Utils::Uploader.bucket.put_object(name, file: tmpfile, content_type: file.type)
            if result
              wrap_meta(name: name)
            else
              wrap_meta(msg: '上传异常')
           end
          end

          desc '上传公有阿里云oss [POST /upload/oss/public]'
          params do
            requires :file, type: File, desc: '文件'
          end
          post '/upload/oss/public' do
            file = params.file
            tmpfile = file.tempfile
            object_key = SecureRandom.hex(16)
            name = (object_key + file.filename).to_s
            result = Utils::Uploader.pubbucket.put_object(name, file: tmpfile, content_type: file.type)
            if result
              url = format('%s%s%s%s', 'https://', Settings.aliyun.pubhost, '/', name)
              wrap_meta(url: url)
            else
              wrap_meta(msg: '上传异常')
            end
          end

          desc '下载阿里云oss [GET /upload/load]'
          params do
            requires :name, type: String, desc: '文件名'
          end
          get '/upload/load' do
            result = Utils::Uploader.bucket.object_url(params.name, true, 3600)
            wrap_meta(url: result)
          end
        end
      end
    end
  end
end
