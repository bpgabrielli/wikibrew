require 'faker'

 # Create Users
 5.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
 end
 users = User.all

# Create Wikis
50.times do
 Wiki.create!(
   user: users.sample,
   title:  Faker::Lorem.sentence,
   body:   Faker::Lorem.paragraph
 )
end
wikies = Wiki.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"