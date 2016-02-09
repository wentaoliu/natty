module Doorkeeper
  class ApplicationController < ::ApplicationController
    include Helpers::Controller
    helper 'doorkeeper/dashboard'
    skip_before_action :require_signin
  end
end
