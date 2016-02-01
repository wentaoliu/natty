class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :content, type: String
  field :like,    type: Array,  default: []

  validates :content, presence: true

end
