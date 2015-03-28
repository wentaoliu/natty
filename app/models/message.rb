class Message
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :content, type: String
  field :read,  type: Array

  validates :content, presence: true

end
