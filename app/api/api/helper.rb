module API
  module Helper
    def present(*)
      super
      set_meta
    end

    def current_user
      host  = headers['Host']
      return User.first if host == 'localhost:3000'

      return @current_user if @current_user

      @current_user = User.find_by(token: headers['Authorization'])&.user
      state_error! unless @current_user

      Raven.extra_context(params: params.as_json, headers: headers.as_json, url: request.url)
      @current_user
    end

    def raven_capture(e)
      Raven.capture_exception(e, tags: { event: 'api' })
    end

    def set_meta(code = 0, message = 'OK')
      status 200

      real_message = message
      real_message = message.join('\n') if message.is_a?(Array)

      result = {}
      result[:meta] = { status: code.to_i, msg: real_message, err: real_message }
      result[:body] = case @body
                      when Hash then @body
                      else @body.as_json || {}
                      end
      @body = result
    end

    def wrap_meta(result, message = 'OK', code = 0)
      status(200)
      result ||= {}

      real_message = message
      real_message = message.join('\n') if message.is_a?(Array)

      ret = {}
      ret[:body] = result
      ret[:meta] = { status: code.to_i, msg: real_message, err: real_message }

      ret
    end

    def state_error!(info = I18n.t('api.auth.login_status_error'))
      render_api_error! set_meta(1, info)
    end

    def unauthorized!(info = I18n.t('api.auth.unauthorized'))
      render_api_error! set_meta(2, info)
    end

    def bad_request!(message)
      render_api_error!(set_meta(3, message))
    end

    def info!(message)
      render_api_error!(set_meta(4, message))
    end

    def render_api_error!(message)
      error!(message, 200)
    end

    def pick_from(hash, *keys)
      return {} unless hash.respond_to?(:key?) && hash.respond_to?(:[])
      result = {}
      keys.flatten.each do |key|
        result[key] = hash[key] if hash.key?(key)
      end

      result
    end
  end
end
