class User < ActiveRecord::Validations

  validates :email, uniqueness: true
  validates_presence_of :name, :email, :password
end
