# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"

puts "Cleaning database..."

Booking.destroy_all
Plant.destroy_all
User.destroy_all

puts "Starting seed 🌱"

names = ['Tay', 'Jamile', 'Clement', 'Martyna', 'Fabienne', 'Marin', 'Ben', 'Gus', 'Paul']
users = []
names.each do |name|
  users << User.create!(email: "#{name}@gmail.com", password: 'password', name: name) 
end

plants = HTTParty.get(
  'https://trefle.io/api/v1/plants',
  query: {
    "token": ENV['TREFLE_API_KEY']
  }
)
plants.parsed_response

list = plants['data']
list[1..20].each do |p|
  name = p['common_name']
  category = Plant::CATEGORIES.sample
  url = ("http://geodb-free-service.wirefreethought.com/v1/geo/cities?offset=#{rand(1..24000)}&limit=1")  
  response = HTTParty.get(url)
  sleep(1)
  city = response.parsed_response['data'].first['city']

  p "name: #{name} city: #{city}" 

  photo = URI.open(p['image_url'])
  plant = Plant.create!(
    name: name,
    address: city,
    user: users.sample,
    price: rand(10..199),
    category: category)
  plant.photos.attach(io: photo, filename: "#{name}.jpeg", content_type: 'image/jpeg')
end

puts "Finished seeding file 😀"




# user1 = User.create!(email: 'jamilemarcele@me.com', password: '123456')

# name: 'Charlie',
# description: 'Charlie is a real cutie. It does not require a lot of attention',
# price: 75,
# category:'indoor',
# user: user1,
# address: 'Tokyo'
# )

# photo2 = URI.open('https://images.unsplash.com/photo-1508988445015-c834399679ef?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1713&q=80')
# plant2 = Plant.create!(
# name: 'Ben',
# description: 'Ben has succulent rosette-form leaves in shades of green, purple, and red',
# price: 50,
# category:'indoor',
# user: user1,
# address: 'Barcelona'
# )
# plant2.photos.attach(io: photo2, filename: 'ben.jpeg', content_type: 'image/jpeg')

# photo3 = URI.open('https://images.unsplash.com/photo-1575574202425-ba42a224118b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80')
# plant3 = Plant.create!(
# name: 'Kitty',
# description: 'Growing Kitty is not only rewarding but extremely tasty. Yummy!',
# price: 90,
# category:'outdoor',
# user: user1,
# address: 'Amsterdam'
# )
# plant3.photos.attach(io: photo3, filename: 'kitty.jpeg', content_type: 'image/jpeg')

# photo4 = URI.open('https://images.unsplash.com/photo-1509937528035-ad76254b0356?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1524&q=80')
# plant4 = Plant.create!(
# name: 'Rosie',
# description: 'drinking cactus Rosie’s water has saved the lives of people traveling through the desert',
# price: 45,
# category:'outdoor',
# user: user1,
# address: 'Lisbon'
# )
# plant4.photos.attach(io: photo4, filename: 'rosie.jpeg', content_type: 'image/jpeg')



