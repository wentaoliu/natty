class HomeController < ApplicationController

  # GET /
  def index
    @messages = Message.order(created_at: :desc).page(1).per(10)
    @message = Message.new
    @schedule = Schedule.where(
                  :starts_at.lte => DateTime.now,
                  :ends_at.gte => DateTime.now,
                  :user => current_user
                )
  end

end
