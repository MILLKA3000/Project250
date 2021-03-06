class User < ActiveRecord::Base
  has_many :journals
  has_many :tasks, through: :journals
attr_accessible :email, :fname, :lname, :login, :password, :password_confirmation
attr_accessor :password
before_save :encrypt_password

validates :fname, presence: true
validates :lname, presence: true
validates :login, presence: true, uniqueness: true
validates :email, presence: true, uniqueness: true
validates :password, presence: true, confirmation: true, :on => :create


def self.authenticate(inp_user, password)
  user = find_by_email(inp_user)
  if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
    user
  else
    user = find_by_login(inp_user)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end

def encrypt_password
  if password.present?
    self.password_salt = BCrypt::Engine.generate_salt
    self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
  end
end
end