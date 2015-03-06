class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :username, type: String
  field :password_digest, type: String
  has_secure_password

  field :name, type: String
  field :email, type: String
  field :remember_token, type: String
  field :avatar, type: String

  field :email_public, type: String
  field :photo, type: String
  field :locale, type: String
  field :position, type: Integer
  field :grade, type: Integer
  field :rank, type: Integer
  field :resume, type: String

  field :last_sign_in_at, type: DateTime
  field :last_sign_in_ip, type: String
  field :current_sign_in_at, type: DateTime
  field :current_sign_in_ip, type: String

  field :state, type: Integer, default: 0
  field :admin, type: Boolean

  before_save { self.username = username.downcase }
  before_create :create_remember_token

  validates :username, presence: true, length: { minimum: 4, maximum: 20 }
  validates :name, presence: true
  validates :email, presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :if => :password_digest_changed?

  has_many :topics, dependent: :destroy
  has_many :wikis
  has_many :news
  has_many :resources
  has_many :schedules
  has_many :bulletins
  has_many :messages

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
