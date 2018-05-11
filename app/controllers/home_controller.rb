class HomeController < ApplicationController

  # GET /
  def index
    @messages = Message.order(created_at: :desc).page(1).per(10)
    @message = Message.new
    @schedule = current_user.schedules.where(
                  'starts_at <= ? AND ends_at >= ?', 
                    DateTime.now, DateTime.now)
  end

end
