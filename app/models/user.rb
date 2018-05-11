class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_and_belongs_to_many :admin_of,  inverse_of: :admins, class_name: 'Group'
  #has_and_belongs_to_many :member_of, inverse_of: :members, class_name: 'Group'

  has_many :topics
  has_many :wikis
  has_many :resources
  has_many :messages
  has_many :inventories
  has_many :bookings
  has_many :schedules
  has_one :profile

  has_attached_file :avatar,
    :styles => { :thumb => ["35x35!", :png] },
    :default_url => 'default/user/avatar/:style/missing.png'

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
  after_create :create_profile

  validates :name,      presence: true

  validates_attachment :avatar, content_type: { content_type: /\Aimage\/.*\Z/ }

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
