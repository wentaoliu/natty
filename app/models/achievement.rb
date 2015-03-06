class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title, type: String
  field :author, type: String
  field :link, type: String
  field :content, type: String
  field :date, type: Date, default: ->{ Date.today }
  field :type, type: Integer, default: 0
  field :public, type: Boolean, default: false

  validates :title, presence: true
end
