# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# User.delete_all
Task.delete_all

# user = User.create(name: 'Eduardo', email: 'eduardo.m.schneiders@gmail.com', password: 'p@ssw0rd')
user = User.first
5.times do |i|
  Task.create(name: "Task seed completed #{i}", user: user, completed: true, completed_at: Time.now, created_at: 1.day.ago)
end

5.times do |i|
  Task.create(name: "Task seed completed #{i}", user: user, completed: true, completed_at: 1.day.ago, created_at: 2.day.ago)
end

5.times do |i|
  Task.create(name: "Task seed #{i}", user: user, completed: false, created_at: 5.day.ago)
end

5.times do |i|
  Task.create(name: "Task seed #{i}", user: user, completed: false, created_at: 10.day.ago)
end
