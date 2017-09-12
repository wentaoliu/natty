module Doorkeeper
  class ApplicationController < ::ApplicationController
    include Helpers::Controller
    helper 'doorkeeper/dashboard'
    skip_before_action :authenticate_user!
  end
end
