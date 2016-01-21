class Order
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :title
  field :quantity,          type: Integer,  default: 0
  field :unit_size
  field :unit_price,        type: Float,    default: 0
  field :total_price,       type: Float,    default: 0
  field :bought_from
  field :type
  field :vendor_name
  field :invoice
  field :notes
  field :hidden,            type: Boolean,  default: false

  validates :title,         presence: true
end
