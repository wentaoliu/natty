class Achievement
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paranoia

  belongs_to :user

  field :title,     type: String
  field :author,    type: String
  field :link,      type: String
  field :content,   type: String
  field :date,      type: Date,     default: -> { Date.today }
  field :type,      type: Integer,  default: 0
  field :hidden,    type: Boolean,  default: false

  TYPE = {
    paper: 0,
    patent: 1,
    award: 2,
    english_paper: 3,
  }

  validates :title, presence: true
  validates :content, presence: true
  validates :date, presence: true

  def self.types
    return TYPE
  end

end
