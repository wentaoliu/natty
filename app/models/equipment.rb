class Equipment
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :users

  field :title, type: String
  field :content, type: String
  field :maintainer, type: BSON::ObjectId
  field :public, type: Boolean, default: false

  validates :title, presence: true
end
