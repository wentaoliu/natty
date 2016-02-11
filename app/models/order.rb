class Order
  include Mongoid::Document
  include Mongoid::Timestamps

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

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :title
    expose :quantity
    expose :unit_size
    expose :unit_price
    expose :total_price
    expose :bought_from
    expose :type
    expose :vendor_name
    expose :invoice
    expose :notes
    expose :hidden
    expose :created_at
    expose :user_id
  end
end
