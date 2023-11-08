class User < ActiveRecord::Base
  has_secure_password

  # Validations
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email, password)
    # Remove leading and trailing spaces from the email
    email = email.strip
    
    # Find a user by email (case-insensitive)
    user = self.where("LOWER(email) = ?", email.downcase).first

    # If a user is found and the password matches, return the user; otherwise, return nil
    if user && user.authenticate(password)
      return user
    else
      return nil
    end
  end

end


