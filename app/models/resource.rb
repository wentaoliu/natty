class Resource
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip

  belongs_to :user

  field :title, type: String
  field :parent, type: BSON::ObjectId
  field :ancestors, type: Array, default: []
  field :is_folder, type: Boolean

  # only for files
  has_mongoid_attached_file :document

  validates_attachment :document,
    size: { in: 0..10.megabytes },
    file_name: { matches: [/png\Z/, /jpe?g\Z/, /gif\Z/, /docx?\Z/, /xlsx?\Z/,
      /pptx?\X/, /rar\Z/, /zip\Z/, /exe\Z/, /pdf\Z/] }

  before_save :set_ancestors

  validates :title, presence: true

  private

  def set_ancestors
    unless parent.nil?
      parent_ancestors = Resource.find(self.parent).ancestors
      self.ancestors = parent_ancestors.push(parent)
    end
  end

  def entity
    Entity.new(self)
  end

  class Entity < Grape::Entity
    expose :id
    expose :title
    expose :parent
    expose :ancestors
    expose :is_folder
    expose :hits
    expose :created_at
    expose :user_id
  end
end
