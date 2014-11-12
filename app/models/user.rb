class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Ables
  include Canable::Cans

  field :email,    type: String
  field :username, type: String
  field :admin,    type: Boolean, default: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  field :encrypted_password, type: String

  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  field :remember_created_at, type: Time

  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  validates :email,    presence: true, uniqueness: true
  validates :username, presence: true, uniqueness: true

  has_many :notes

  def viewable_by?(u)
    u == self || u.admin?
  end

  def creatable_by?(u)
    true
  end

  def updatable_by?(u)
    u == self || u.admin?
  end

  def destroyable_by?(u)
    u == self || u.admin?
  end
end
