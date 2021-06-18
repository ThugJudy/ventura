# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# User.create!(name: "Pritham",
#   email: "pritham@chronus.com",
#   password:              "123456",
#   password_confirmation: "123456",
#   admin: true)
# # Generate a bunch of additional users.
# 99.times do |n|
# name = Faker::Name.name
# email = Faker::Internet.email
# password = "123456"
# User.create!(name: name,
#     email: email,
#     password:              password,
#     password_confirmation: password)
# # Generate microposts for a subset of users.

users = User.order(created_at: :desc).take(2)
15.times do  |n|
  users.each do |user| 
    user.ideas.create!(
    title: Faker::Name.name,
    #thumbnail: Faker::LoremPixel.image("600x400"),
    stake: Faker::Number.between(from: 1, to: 99), 
    domain: ["physics","cloud","ML","AI"][Faker::Number.between(from: 0, to: 3)], 
    decription: Faker::Lorem.sentence(word_count: 100)) 
  end
end