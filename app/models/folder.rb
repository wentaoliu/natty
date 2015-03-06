class Folder
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user
  has_many :files
end
