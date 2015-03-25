class Bulletin
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :title, type: String
  field :content, type: String
  field :public, type: Boolean, default: false

  validates :title, presence: true
end
