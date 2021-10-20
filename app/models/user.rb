class User < ActiveRecord::Base
  has_secure_password
  
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: {minimum: 6}

  before_validation :lower_email_case

  def authenticate_with_credentials(email, password)
    user = User.find_by(email: email.strip).try(:authenticate, password)
    return user ||= nil
  end

  private
  
  def lower_email_case
    self.email.downcase!
  end

end
