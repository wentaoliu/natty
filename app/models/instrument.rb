class Instrument
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title,       type: String
  field :content,     type: String
  field :maintainer,  type: BSON::ObjectId
  field :hidden,      type: Boolean, default: false

  validates :title, presence: true
  validates :content, presence: true

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :maintainer
    expose :created_at
    expose :user_id
  end
end
