class User < ActiveRecord::Base
  attr_accessor :name, :email, :password

  validates :email, uniqueness: true
  validates_presence_of :name, :email, :password
end
