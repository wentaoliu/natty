class Version < ApplicationRecord

  belongs_to :wiki

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
