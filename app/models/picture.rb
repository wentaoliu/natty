class Picture < ApplicationRecord

  has_attached_file :image,
    :styles => { :medium => "600x600>", :thumb => "100x100>" }

  validates_attachment :image, content_type: { content_type: /\Aimage\/.*\Z/ }

end
