# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "open-uri"
require 'httparty'

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
  scientific_name = p['scientific_name']
  family_common_name = p['family_common_name']
  category = Plant::CATEGORIES.sample
  url = ("http://geodb-free-service.wirefreethought.com/v1/geo/cities?offset=#{rand(1..24000)}&limit=1")  
  response = HTTParty.get(url)
  sleep(1)
  city = response.parsed_response['data'].first['city']

  p "name: #{name} city: #{city}" 

  photo = URI.open(p['image_url'])
  plant = Plant.create!(
    name: name,
    description: "Also called #{scientific_name}. Is a species of #{family_common_name}.",
    address: city,
    user: users.sample,
    price: rand(10..199),
    category: category)
  plant.photos.attach(io: photo, filename: "#{name}.jpeg", content_type: 'image/jpeg')
end

puts "Finished seeding file 😀"