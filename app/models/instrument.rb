class Instrument < ApplicationRecord

  has_many :bookings
  
  validates :name, presence: true

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
