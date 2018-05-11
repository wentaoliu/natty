class Message < ApplicationRecord

  belongs_to :user

  validates :content, presence: true

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :content
    expose :like
    expose :created_at
    expose :user_id
  end
end
