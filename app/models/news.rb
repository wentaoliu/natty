class News
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title,   type: String
  field :content, type: String
  field :hits,    type: Integer, default: 0
  field :hidden,  type: Boolean, default: false

  validates :title, presence: true
  validates :content, presence: true
end
