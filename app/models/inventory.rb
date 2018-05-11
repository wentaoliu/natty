class Inventory < ApplicationRecord

  belongs_to :user

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
