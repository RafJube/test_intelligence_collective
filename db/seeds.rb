# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"

# Initialisation

puts "Destroy everything..."

User.destroy_all if Rails.env.development?
Test.destroy_all if Rails.env.development?
Category.destroy_all if Rails.env.development?

puts "Done"
puts "-------------------------"
puts "Creating Users..."

User.create!(
  username: "Raf",
  email: "raphaeljube@ymail.com",
  password: "secret"
)

User.create!(
  username: "Admin",
  email: "admin@admin.com",
  password: "secret",
  admin: true
)

puts "Done"
puts "-------------------------"
puts "Creating Categories..."

@categories = ["logique", "imagination", "optimisation", "coodination", "sensibilité"]
@categories.each do |category|
  Category.create(name: category)
end

puts "Done"
puts "-------------------------"
puts "Creating Tests..."

test = Test.new(
  name: "liste de mots",
  duration: 600,
  description: "Ecrivez un maximum de mots commençant par 'A' et finissant par 'N' (example: 'amidon').",
  solution: "50")
test.category_id = Category.find_by_name("imagination").id
test.save

puts "All Good Boys"
puts "-------------------------"
