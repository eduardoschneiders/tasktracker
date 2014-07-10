class User < ActiveRecord::Base
  validates :email, uniqueness: true
  validates_presence_of :name, :email, :password

  def self.auth(email, password)
    User.where(email: email, password: password)
  end
end
