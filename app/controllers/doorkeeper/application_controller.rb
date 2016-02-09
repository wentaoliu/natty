module Doorkeeper
  class ApplicationController < ::ApplicationController
    include Helpers::Controller
    helper 'doorkeeper/dashboard'
  end
end
