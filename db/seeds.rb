# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Task.delete_all

user = User.create(name: 'Eduardo', email: 'eduardo.m.schneiders@gmail.com', password: CaesarEncrypt.encrypt('eduardo', 5))
5.times do |i|
  Task.create(name: "Taks seed #{i}", user: user)
end
