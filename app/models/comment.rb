class Comment < ApplicationRecord

  belongs_to :topic, counter_cache: :comments_count
  
  validates :content, presence: true

  def user
    User.find(self.user_id)
  end
  def user=(user)
    self.user_id = user.id
  end
  def parent
    self.topic
  end
  def replies
    parent.comments.where(reply_to: self.id)
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :reply_to
    expose :content
    expose :user_id
  end
end
