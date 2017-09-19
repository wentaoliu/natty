class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Paperclip
  include Mongoid::Paranoia

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, #:confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_and_belongs_to_many :admin_of,  inverse_of: :admins, class_name: 'Group'
  #has_and_belongs_to_many :member_of, inverse_of: :members, class_name: 'Group'

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

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  field :remember_token,        type: String

  has_mongoid_attached_file :avatar,
    :styles => { :thumb => ["35x35!", :png] },
    :default_url => 'default/user/avatar/:style/missing.png'

  has_mongoid_attached_file :photo,
    :styles => { :small => ["300x300", :png] },
    :default_url => 'default/user/photo/:style/missing.png'

  field :name,                  type: String
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

  STATE = {
    inactive: 0,
    normal: 1,
    blocked: 2,
  }

  def self.states
    return STATE
  end

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

  field :state,               type: Integer,  default: STATE[:inactive]
  field :admin,               type: Boolean,  default: false
  field :permission,          type: Integer,  default: PERMISSION[:create]

  def normal?
    return self.state == STATE[:normal]
  end

  def superadmin?
    return self.name == 'admin'
  end

  def admin?
    return self.admin || superadmin?
  end

  before_create :generate_remember_token

  validates :name,      presence: true

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }
  validates_attachment :photo,  content_type: { content_type: /\Aimage\/.*\Z/ }

  def ability
    @ability ||= Ability.new(self)
  end
  delegate :can?, :cannot?, :to => :ability

  def self.find_by_remember_token(token)
    where(remember_token: User.digest(token)).first
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

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

end
