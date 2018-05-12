module V1
  module Helpers

    def token_authorize!
      error!("401 Unauthorized", 401) unless authenticated?
    end
    
    def authenticated?
      !access_token&.empty? && @current_user ||= User.find_by_authentication_token(access_token)
    end

    def access_token
      pattern = /^Token /
      header = request.headers['Authorization']
      header.gsub(pattern, '') if header && header.match(pattern)
    end

    def current_user
      @current_user ||= User.find_by_authentication_token(access_token)
    end
  end
end
