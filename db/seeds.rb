require 'faker'

 # Create Users
 5.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10)
    )
 end
  # Create Premium Users
 2.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: Faker::Lorem.characters(10),
    role: "premium"
    )
 end
 users = User.all
 premium_users = User.where(role: "premium")

# Create Wikis
50.times do
 Wiki.create!(
   user: users.sample,
   title:  Faker::Lorem.sentence,
   body:   Faker::Lorem.paragraph
 )
end
# Create Private Wikis
5.times do
 Wiki.create!(
   user: premium_users.sample,
   title:  Faker::Lorem.sentence,
   body:   Faker::Lorem.paragraph,
   private: true
 )
end
wikis = Wiki.all
private_wikis = Wiki.where(private: true)

# Create Collaborations
3.times do
 Collaboration.create!(
   user: premium_users.sample,
   wiki: private_wikis.sample,
 )
end
collaborations = Collaboration.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
puts "#{premium_users.count} premium users created"
puts "#{private_wikis.count} private wikis created"
puts "#{Collaboration.count} collaborations created"