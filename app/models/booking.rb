class Booking
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :instrument
  belongs_to :user

  field :starts_at, type: DateTime, default: ->{ DateTime.now }
  field :ends_at,   type: DateTime, default: ->{ DateTime.now + 1.hour }
  field :record,    type: String

  validates :starts_at, presence: true
  validates :ends_at,   presence: true
end
