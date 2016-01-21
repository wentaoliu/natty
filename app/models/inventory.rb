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
  field :hidden,            type: Boolean,  default: false

  validates :item_name,     presence: true
end
