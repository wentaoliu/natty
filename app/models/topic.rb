class Topic < ApplicationRecord

  belongs_to :user
  belongs_to :forum
  has_many :comments
  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  def tags_list=(arg)
    self.tags = arg.split(',').map { |v| v.strip }
  end

  def tags_list
    self.tags.join(',')
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :content
    expose :tags
    expose :created_at
    expose :user_id
  end
end
