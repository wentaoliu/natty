class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include ActiveModel::SecurePassword

  field :username,              type: String
  field :password_digest,       type: String
  has_secure_password

  field :name,                  type: String
  field :email,                 type: String
  field :email_verified,        type: Boolean,  default: false
  field :remember_token,        type: String

  has_mongoid_attached_file :avatar,
    :styles => { :thumb => ["35x35!", :png] },
    :default_url => 'default/user/avatar/:style/missing.png'

  has_mongoid_attached_file :photo,
    :styles => { :small => ["300x300", :png] },
    :default_url => 'default/user/photo/:style/missing.png'

  field :email_public,          type: String
  field :locale,                type: String,   default: I18n.default_locale
  field :position,              type: Integer,  default: 0

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

  field :grade,                 type: Integer,  default: Date.today.year
  field :rank,                  type: Integer,  default: 0
  field :resume,                type: String

  field :last_sign_in_at,       type: DateTime
  field :last_sign_in_ip,       type: String
  field :current_sign_in_at,    type: DateTime
  field :current_sign_in_ip,    type: String

  field :verify_email_token,    type: String
  field :verify_email_time,     type: DateTime

  field :reset_password_token,  type: String
  field :reset_password_time,   type: DateTime

  STATE = {
    inactive: 0,
    normal: 1,
    blocked: 2,
  }

  def self.states
    return STATE
  end

  field :state,               type: Integer,  default: STATE[:inactive]
  field :admin,               type: Boolean,  default: false

  def normal?
    return self.state == STATE[:normal]
  end

  def superadmin?
    return self.username == 'admin'
  end

  def admin?
    return self.admin || superadmin?
  end

  before_save { self.username = username.downcase }
  before_create :create_remember_token

  validates :username,  presence: true, uniqueness: true,
            length:     { minimum: 4, maximum: 20 },
            format:     { with: /\A[a-zA-Z0-9]+\Z/ }

  validates :name,      presence: true
  validates :email,     presence: true,
            format:     { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :password,  length: { minimum: 6 }, :if => :password_digest_changed?

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment :photo,  content_type: { content_type: /\Aimage\/.*\Z/ }

  PERMISSION = {
    none: 0,
    read: 1,
    create: 2,
    update: 3,
    manage: 4,
  }

  def self.permissions
    return PERMISSION
  end

  has_many :topics,        dependent: :destroy
  field :auth_topic,       type: Integer,  default: 1
  field :auth_comment,     type: Integer,  default: 1

  has_many :wikis
  field :auth_wiki,        type: Integer,  default: 1

  has_many :news
  field :auth_news,        type: Integer,  default: 1

  has_many :resources
  field :auth_resource,    type: Integer,  default: 1

  has_many :achievements
  field :auth_achievement, type: Integer,  default: 1

  has_many :schedules

  has_many :instruments
  field :auth_instrument,  type: Integer,  default: 1

  has_many :bulletins
  field :auth_bulletin,    type: Integer,  default: 1

  has_many :meetings
  field :auth_meeting,     type: Integer,  default: 1

  has_many :messages

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
