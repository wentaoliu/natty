class HomeController < ApplicationController

  # GET /
  def index
    @messages = Message.order(created_at: :desc).page(1).per(10)
    @message = Message.new
    @meetings = if can?(:create, Meeting)
      Meeting.where(:starts_at.lte => DateTime.now, :ends_at.gte => DateTime.now)
    else
      Meeting.where(hidden: false, :starts_at.lte => DateTime.now, :ends_at.gte => DateTime.now)
    end
    @schedule = Schedule.where(
                  :starts_at.lte => DateTime.now,
                  :ends_at.gte => DateTime.now,
                  :user => current_user
                )
    @news = if can?(:create, News)
      News.order(created_at: :desc).limit(3)
    else
      News.where(hidden: false).order(created_at: :desc).limit(3)
    end
  end

end
