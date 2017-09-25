class Topic
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  belongs_to :forum
  embeds_many :comments

  field :title,           type: String
  field :content,         type: String
  field :tags,            type: Array,   default: []
  field :comments_count,  type: Integer
  field :hits,            type: Integer, default: 0
  field :hidden,          type: Boolean, default: false
  field :allow_comments,  type: Boolean, default: true

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
