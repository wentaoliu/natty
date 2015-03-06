class Wiki
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Versioning
  include Mongoid::Paranoia

  belongs_to :user

  field :title, type: String
  field :hits, type: String, default: 0
  field :public, type: Boolean, default: false
  field :comment
  field :content

  validates :title, presence: true
  validates :comment, presence: true
  validates :content, length: { minimum: 50 }
end
