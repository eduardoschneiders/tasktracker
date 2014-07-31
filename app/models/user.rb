class User < ActiveRecord::Base
  has_many :tasks

  validates :email, uniqueness: true
  validates_presence_of :name, :email, :password

  def self.auth(email, password)
    User.where(email: email, password: password).first
  end

  def public_data
    { name: self.name, email: self.email }
  end
end
