class Permission
  include Mongoid::Document

  embedded_in :user
  embedded_in :group

  field :topic,       type: Integer,  default: 1
  field :comment,     type: Integer,  default: 1
  field :wiki,        type: Integer,  default: 1
  field :news,        type: Integer,  default: 1
  field :resource,    type: Integer,  default: 1
  field :inventory,   type: Integer,  default: 1
  field :achievement, type: Integer,  default: 1
  field :instrument,  type: Integer,  default: 1
  field :order,    type: Integer,  default: 1
  field :meeting,     type: Integer,  default: 1
end
