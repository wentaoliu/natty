class Wiki
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  embeds_many :versions

  field :title,     type: String
  field :category,  type: String
  field :content,   type: String
  field :comment,   type: String

  field :locked,    type: Boolean,  default: false

  validates :title, presence: true

  def create_version
    self.versions.create(
      title: self.title,
      category: self.category,
      content: self.content,
      comment: self.comment,
      user_id: self.user_id,
      current: true
    )
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :hits
    expose :comment
    expose :created_at
    expose :user_id
  end
end
