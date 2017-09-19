class Wiki
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title,   type: String
  field :hits,    type: Integer,  default: 0
  field :hidden,  type: Boolean,  default: false
  field :comment
  field :content

  validates :title, presence: true
  validates :comment, presence: true
  validates :content, length: { minimum: 50 }

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :hits
    expose :comment
    expose :created_at
    expose :user_id
  end
end
