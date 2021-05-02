class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  before_save :sanitize_text

  USERNAME_REGEX_VALID = /\A[a-zA-Z\s-]+\z/

  validates_presence_of :username,:email, message: "Can't be blank"
  validates :username, uniqueness: true, format: { with: USERNAME_REGEX_VALID, message: 'Username with special character arent allowed, only "-" is allowed' }                     
  validates :email, email: true, uniqueness: true, length: {maximum:100}

  def sanitize_text
    self.username = username.downcase
    self.email = email.downcase
  end

end
