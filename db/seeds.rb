# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Task.delete_all

user = User.create(name: 'Eduardo', email: 'eduardo.m.schneiders@gmail.com', password: 'eduardo')
5.times do |i|
  Task.create(name: "Task seed #{i}", user: user, completed: true, completed_at: Time.now)
end
