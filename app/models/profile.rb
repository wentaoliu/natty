class Profile < ApplicationRecord

  belongs_to :user

  has_attached_file :photo,
    :styles => { :small => ["300x300", :png] },
    :default_url => 'default/user/photo/:style/missing.png'

  POSITIONS = {
    undergraduate: 0,
    postgraduate: 1,
    doctoral: 2,
    postdoctoral: 3,
    associate: 4,
    professor: 5,
    graduate: 6,
    lecturer: 7,
    assistant: 8,
    engineer: 9,
  }

  def self.positions
    return POSITIONS
  end

  validates_attachment :photo,  content_type: { content_type: /\Aimage\/.*\Z/ }

end
