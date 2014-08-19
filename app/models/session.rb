class Session
  include ActiveModel::Model

  attr_accessor :email, :password
  attr_reader :user

  def initialize(attributes = {})
    @email = attributes[:email]
    @password = attributes[:password]
  end

  def create
    @user = User.find_by(email: @email, password: User.encrypted_password(@password))
    return true if @user.present?
  end
end
