require 'rails_helper'

describe User do
  let(:password)  { 'p@ssw0rd' }
  let(:user)      { User.create(name: 'Eduardo', email: 'email@gmail.com', password: password) }
  let(:group)     { user.groups.create(name: 'Group A') }

  it 'encrypts password'  do
    expect(user.password).not_to eql 'p@ssw0rd'
  end

  it 'has many groups' do
    user.groups.create(name: 'Group A')
    user.groups.create(name: 'Group B')

    expect(user.groups.count).to eql 2
  end

  it 'has many tasks' do
    user.tasks.create(name: 'Task one', group: group)
    user.tasks.create(name: 'Task two', group: group)

    expect(user.tasks.count).to eql 2
  end
end
