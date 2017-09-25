class Version
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :wiki

  field :user_id,   type: BSON::ObjectId
  field :title,     type: String
  field :category,  type: String
  field :content,   type: String
  field :comment,   type: String
  field :current,   type: Boolean, default: false

  validates :content, presence: true

  def rollback
    self.wiki.versions.find_by(current: true).update(current: false)
    self.current = true
    self.wiki.update(
      title: self.title,
      category: self.category,
      content: self.content,
      comment: self.comment,
      updated_at: self.created_at
    )
  end

  def user
    User.find(self.user_id)
  end
  def user=(user)
    self.user_id = user.id
  end
end
