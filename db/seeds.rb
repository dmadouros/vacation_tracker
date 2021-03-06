# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create!(email: 'employee@athn.org', password: 'password')
profile = Profile.create!(hired_on: '11-Nov-2013', pto_hours_used: 72)
user.profile = profile
user.save!