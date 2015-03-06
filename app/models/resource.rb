class Resource
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user

  field :title, type: String
  field :parent, type: BSON::ObjectId
  field :ancestors, type: Array, default: []
  field :is_folder, type: Boolean
  # only for files
  field :content_type, type: String
  field :size, type: Integer
  field :filename, type: String
  field :public, type: Boolean, default: false
  field :hits, type: Integer, default: 0

  before_save :set_ancestors

  validates :title, presence: true

  private

  def set_ancestors
    unless parent.nil?
      parent_ancestors = Resource.find(self.parent).ancestors
      self.ancestors = parent_ancestors.push(parent)
    end
  end
end
