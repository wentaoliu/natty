class HomeController < ApplicationController

  # GET /
  def index
    @messages = Message.where(
                  :read.nin => [current_user.id],
                  :created_at.gt => current_user.created_at
                )
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
      News.order(created: :desc).limit(3)
    else
      News.where(hidden: false).order(created: :desc).limit(3)
    end
  end

end
