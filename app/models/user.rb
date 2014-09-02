class User < ActiveRecord::Base
  has_many :tasks

  validates :email, uniqueness: true
  validates_presence_of :name, :email, :password

  before_create :encrypt_password!

  def encrypt_password!
      self.password = User.encrypted_password(password)
  end

  def self.encrypted_password(password)
    CaesarEncrypt.encrypt(password, 5)
  end
end
