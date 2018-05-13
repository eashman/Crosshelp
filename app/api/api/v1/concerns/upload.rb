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
            wrap_meta(result: result)
          end
        end
      end
    end
  end
end
