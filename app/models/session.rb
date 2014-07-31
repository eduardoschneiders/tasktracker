class Session
  include ActiveModel::Model

  attr_accessor :email, :password

  def initialize(attributes = {})
    @email = attributes[:email]
    @password = attributes[:password]
  end

  def auth
    user = User.auth(@email, @password)
    if user.present?
      return user.public_data
    end
  end
end
