class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Canable::Ables
  include Canable::Cans

  field :email,    type: String
  field :name,     type: String
  field :admin,    type: Boolean, default: false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:dropbox_oauth2]

  field :provider, type: String
  field :uid, type: String

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

  def self.from_omniauth(auth)
    d { auth }
    d { auth.token }
    d { auth.extra.raw_info.email }

    u = where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.extra.raw_info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.extra.raw_info.display_name
    end

    d { u }

    u
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.dropbox_oauth2'] && session['devise.dropbox_oauth2']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  # Workaround for serialization issues with Moped (see
  #   https://github.com/plataformatec/devise/pull/2882).
  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]['$oid'])
      record if record && record.authenticatable_salt == salt
    end
  end
end
