require 'rails_helper'

describe Task do
  let(:user)  { User.create(name: 'Eduardo', email: 'email@gmail.com', password: 'p@ssw0rd') }
  let(:group) { Group.create(name: 'Group A', user: user) }

  subject { user.tasks.create(name: 'Task XYZ', group: group) }
  
  it 'belongs to a user' do
    expect(subject.user).to eql user
  end

  it 'belongs to a group' do
    expect(subject.group).to eql group
  end
end
