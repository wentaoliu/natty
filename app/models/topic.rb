class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :forum
  embeds_many :comments

  field :title,           type: String
  field :content,         type: String
  field :category,        type: String
  field :tags,            type: String#Array
  field :comments_count,  type: Integer
  field :hits,            type: Integer, default: 0
  field :hidden,          type: Boolean, default: false

  validates :title, presence: true
  validates :content, length: { minimum: 50 }

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :category
    expose :tags
    expose :created_at
    expose :user_id
  end
end
