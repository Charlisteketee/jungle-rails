class User < ApplicationRecord
  has_secure_password # rails automatically handles password_confirmation field with this.
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }

  def self.authenticate_with_credentials(email, password)
    user = find_by(email: email.downcase.strip)
    user && user.authenticate(password)
  end
end
