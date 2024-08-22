class User < ApplicationRecord
  has_secure_password

  validates :password, length: { minimum: 6 }, on: :create
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    user = User.find_by('LOWER(email) = ?', email.strip.downcase)
    user && user.authenticate(password) ? user : nil
  end
end
