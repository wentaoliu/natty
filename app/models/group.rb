class Group
  include Mongoid::Document
  include Mongoid::Timestamps

  has_and_belongs_to_many :members, inverse_of: :member_of, class_name: 'User'

  field :name,  type: String
  field :description

end
