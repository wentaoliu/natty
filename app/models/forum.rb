class Forum
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :topics

  field :name,        type: String
  field :description, type: String
  field :hidden,      type: Boolean
end
