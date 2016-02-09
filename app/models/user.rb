class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Paranoia
  include ActiveModel::SecurePassword

  has_and_belongs_to_many :admin_of,  inverse_of: :admins, class_name: 'Group'
  has_and_belongs_to_many :member_of, inverse_of: :members, class_name: 'Group'

  has_many :topics, dependent: :destroy
  has_many :wikis
  has_many :news
  has_many :resources
  has_many :achievements
  has_many :schedules
  has_many :instruments
  has_many :orders
  has_many :meetings
  has_many :messages
  has_many :inventories

  embeds_one :permission, autobuild: true
  accepts_nested_attributes_for :permission

  field :username,              type: String
  field :password_digest,       type: String
  has_secure_password

  field :name,                  type: String
  field :email,                 type: String
  field :email_verified,        type: Boolean,  default: false

  field :remember_token,        type: String
  field :api_token,             type: String

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
  before_create :generate_api_token
  before_create :generate_remember_token
  before_create :generate_verify_email_token

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

  def merged_permission
    permissions_array = [self.permission, self.member_of.map(&:permission)].flatten
    permissions_array.reduce do |a, b|
      a.attributes.merge(b.attributes) { |key, v1, v2| v1 > v2 ? v1 : v2 }
    end
  end

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  def self.find_by_remember_token(token)
    where(remember_token: User.digest(token)).first
  end

  # Find by email or username
  def self.find_and_authenticate(who, password)
    user = any_of({ email: who.downcase }, { username: who }).first
    user if user && user.authenticate(password)
  end

  def generate_api_token
    self.api_token = User.digest(SecureRandom.urlsafe_base64)
  end

  def generate_api_token!
    raw_token = SecureRandom.urlsafe_base64
    self.api_token = User.digest(raw_token)
    save!
    return raw_token
  end

  def generate_remember_token
    self.remember_token = User.digest(SecureRandom.urlsafe_base64)
  end

  def generate_remember_token!
    raw_token = SecureRandom.urlsafe_base64
    self.remember_token = User.digest(raw_token)
    save!
    return raw_token
  end

  def generate_verify_email_token
    self.verify_email_token = SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

end
