class HomeController < ApplicationController
  before_filter :require_signin

  # GET /
  def index
  end

end
