class Inventory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :item_name
  field :price,             type: Float,    default: 0
  field :quantity,          type: Integer,  default: 0
  field :unit_size
  field :url
  field :technical_details
  field :expiration_date,   type: Date
  field :cas_number
  field :serial_number
  field :bought_from
  field :location
  field :sub_location
  field :location_details
  field :type
  field :vendor_name

  validates :item_name,     presence: true

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :item_name
    expose :price
    expose :quantity
    expose :unit_size
    expose :url
    expose :technical_details
    expose :expiration_date
    expose :cas_number
    expose :serial_number
    expose :bought_from
    expose :location
    expose :sub_location
    expose :location_details
    expose :type
    expose :vendor_name
    expose :created_at
    expose :user_id
  end
end
