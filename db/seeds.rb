# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.delete_all
Task.delete_all

user = User.create(name: 'Eduardo', email: 'eduardo.m.schneiders@gmail.com', password: 'p@ssw0rd')

t_before1 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 8.months.ago)
t_before2 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 8.months.ago)
t_before3 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 5.months.ago)
t_before4 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 5.months.ago)
t_before5 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 4.months.ago)
t_before6 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 4.months.ago)
t_before7 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 3.months.ago)
t_before8 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 3.months.ago)
t_before9 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 2.months.ago)
t_before10 = Task.create(name: "Task seed todo before 30 days", user: user, created_at: 2.months.ago)

t1 = Task.create(name: "Task seed todo 1", user: user, created_at: 29.days.ago)
t2 = Task.create(name: "Task seed todo 2", user: user, created_at: 25.days.ago)
t3 = Task.create(name: "Task seed todo 3", user: user, created_at: 20.days.ago)
t4 = Task.create(name: "Task seed todo 4", user: user, created_at: 15.days.ago)

t1.update_attributes(completed: true, completed_at: 28.days.ago)
t2.update_attributes(completed: true, completed_at: 24.days.ago)
t3.update_attributes(completed: true, completed_at: 19.days.ago)
t4.update_attributes(completed: true, completed_at: 14.days.ago)

t_before1.update_attributes(completed: true, completed_at: 26.days.ago)
t_before2.update_attributes(completed: true, completed_at: 26.days.ago)
t_before3.update_attributes(completed: true, completed_at: 25.days.ago)
t_before4.update_attributes(completed: true, completed_at: 20.days.ago)
t_before5.update_attributes(completed: true, completed_at: 15.days.ago)
t_before6.update_attributes(completed: true, completed_at: 7.days.ago)
t_before7.update_attributes(completed: true, completed_at: 7.days.ago)
t_before8.update_attributes(completed: true, completed_at: 3.days.ago)
t_before9.update_attributes(completed: true, completed_at: 3.days.ago)
t_before10.update_attributes(completed: true, completed_at: 1.day.ago)
