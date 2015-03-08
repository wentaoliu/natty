class MessagesController < ApplicationController
  before_filter :require_signin

  def index
    @message = Message.where("'to' = ANY (?)",current_user.id)
  end

end
