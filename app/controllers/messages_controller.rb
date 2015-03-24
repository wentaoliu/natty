class MessagesController < ApplicationController
  before_filter :require_signin

  def index
    @message = Message.all
  end

end
