class Schedule
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title, type: String
  field :starts_at, type: DateTime, default: ->{ DateTime.now }
  field :ends_at, type: DateTime, default: ->{ DateTime.now + 1.hour }
  field :place, type: String
  field :content, type: String
  field :hidden, type: Boolean, default: false

  validates :title, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true

  def self.find_by_user_and_month(user, year, month)
    start_date = DateTime.new(year,month)
    end_date = start_date + 1.month
    where(user: user)
      .any_of({:starts_at.gte => start_date, :starts_at.lt => end_date},
              {:ends_at.gte => start_date, :ends_at.lt => end_date })
  end

end
