class Session
  include ActiveModel::Validations
  include ActiveModel::Conversion
  include ActiveModel::Naming

  attr_accessor :email, :password

  def initialize(attributes = {})
    @email = attributes[:email]
    @password = attributes[:password]
  end
end
