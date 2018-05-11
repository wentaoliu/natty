class Wiki < ApplicationRecord

  belongs_to :user
  has_many :versions
  
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
