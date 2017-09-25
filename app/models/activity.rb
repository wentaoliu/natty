class Activity
  include Mongoid::Document
  include Mongoid::Timestamps

  field :owner,         type: BSON::ObjectId
  filed :action,        type: String
  field :subject_id,    type: BSON::ObjectId
  field :subject_type,  type: String
  field :summary,       type: String

end
