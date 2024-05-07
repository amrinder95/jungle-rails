class User < ApplicationRecord

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.strip.downcase)
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end
      
  has_secure_password
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: {minimum: 6}, presence: true
  validates :password_confirmation, length: {minimum: 6}, presence: true
  validates :email, presence: true, uniqueness: true

end
