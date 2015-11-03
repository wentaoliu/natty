class Instrument
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :title,       type: String
  field :content,     type: String
  field :maintainer,  type: BSON::ObjectId
  field :hidden,      type: Boolean, default: false

  validates :title, presence: true
  validates :content, presence: true
end
