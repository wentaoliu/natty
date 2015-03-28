class HomeController < ApplicationController
  before_filter :require_signin

  # GET /
  def index
    @messages = Message.where(
                  :read.nin => [current_user.id],
                  :created_at.gt => current_user.created_at
                )
    @meetings = Meeting.where(
                  :starts_at.lte => DateTime.now,
                  :ends_at.gte => DateTime.now
                )
    @schedule = Schedule.where(
                  :starts_at.lte => DateTime.now,
                  :ends_at.gte => DateTime.now,
                  :user => current_user
                )
    @news = News.limit(3).order(created: :desc)
  end

end
