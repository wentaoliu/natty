class MessagesController < ApplicationController

  def index
    @message = Message.where("'to' = ANY (?)",current_user.id)
  end

end
