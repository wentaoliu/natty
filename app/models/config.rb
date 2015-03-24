class Config
  include Mongoid::Document

  field :user_id, type: BSON::ObjectId
  field :reply_to, type: BSON::ObjectId
  field :content, type: String

  validates :content, presence: true

  def user
    User.find(self.user_id)
  end
  def user=(user)
    self.user_id = user.id
  end


end
