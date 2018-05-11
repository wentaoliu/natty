class Schedule < ApplicationRecord

  belongs_to :user

  validates :title,     presence: true
  validates :starts_at, presence: true
  validates :ends_at,   presence: true

  def self.find_by_user_and_month(user, year, month)
    start_date = DateTime.new(year,month)
    end_date = start_date + 1.month
    where(user: user)
      .where('starts_at >= ? AND starts_at < ?', start_date, end_date)
      .or(where('ends_at >= ? AND ends_at < ?', start_date, end_date))
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :starts_at
    expose :ends_at
    expose :place
    expose :created_at
    expose :user_id
  end
end
