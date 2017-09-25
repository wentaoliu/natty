class Instrument
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :bookings

  field :name,          type: String
  field :location,      type: String
  field :serial_number, type: String
  field :description,   type: String
  field :maintainer,    type: BSON::ObjectId
  field :available,     type: Boolean,  default: true

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
