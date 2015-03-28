class Meeting
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :title, type: String
  field :content, type: String
  field :starts_at, type: DateTime, default: ->{ DateTime.now }
  field :ends_at, type: DateTime, default: ->{ DateTime.now + 1.hour }
  field :place, type: String
  field :public, type: Boolean, default: false

  validates :title, presence: true
  validates :content, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
