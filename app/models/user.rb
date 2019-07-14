class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: { case_sensitive: false }
  validates :email, :access_token, presence: true

  has_many :decks, dependent: :destroy

  before_validation :ensure_access_token

  def ensure_access_token
    self.access_token = generate_access_token if access_token.blank?
  end

  def self.authenticate(email, password)
    user = User.find_by(email: email)
    return nil unless user && user.authenticate(password)
    user
  end

  private

  def generate_access_token
    loop do
      token = SecureRandom.hex
      break token unless User.where(access_token: token).exists?
    end
  end
end
