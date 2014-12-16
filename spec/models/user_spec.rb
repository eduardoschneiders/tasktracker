require 'rails_helper'

describe User do
  it 'encrypts password'  do
    user = User.create(name: 'Eduardo', email: 'email@gmail.com', password: 'p@ssw0rd')
    expect(user.password).not_to eql 'p@ssw0rd'
  end
end
