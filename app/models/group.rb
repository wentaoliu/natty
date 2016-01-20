class Group
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :admins,  inverse_of: :admin_of, class_name: 'User'
  has_and_belongs_to_many :members, inverse_of: :member_of, class_name: 'User'

  embeds_one :permission, autobuild: true
  accepts_nested_attributes_for :permission

  field :name,  type: String
  field :description

end
