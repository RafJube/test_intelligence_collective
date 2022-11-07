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
puts "Test 1"

test = Test.new(
  name: "liste de mots",
  duration: 600,
  description: "Ecrivez un maximum de mots commençant par 'A' et finissant par 'N' (example: 'amidon').",
  solution: "30"
)
test.category_id = Category.find_by_name("imagination").id
test.save

puts "Test 2"
solution = {
  solutions_list: [
    "2 réservoires de 50kg d'oxygène chacun",
    "25 litres d'eau",
    "Une carte céleste des constellations lunaires",
    "Des aliments concentrés",
    "Un émetteur-récepteur fonctionnant sur l'énergie solaire (fréquence moyenne)",
    "50 mètres de corde en nylon",
    "Une trousse médicale avec seringues hypodermiques",
    "Un parachute en soie",
    "Un canot de sauvetage auto-gonflable",
    "Des signaux lumineux",
    "2 pistolets chargés",
    "Une caisse de lait en poudre",
    "Un appareil de chauffage à énergie solaire",
    "Un compas magnétique"
  ],
  explanations: [
    "Essentiel à la survie",
    "Indispensable face à la déshydratation",
    "Indispensable pour s'orienter",
    "Efficace pour faire le plein d'énergie",
    "Utile pour communiquer avec la base",
    "Utile pour escalader ou hisser des choses ou des blessés",
    "Utile d'autant que la NASA a prévu une ouverture spéciale dans la combinaison",
    "Peut servir à se protéger des rayons solaires",
    "Un traîneau pour des objets et le gaz peut servir à la propulusion",
    "Utiles quand la base sera en vue",
    "Peut accélérer la propulsion ou se suicider en dernier recours...",
    "Trop encombrant!",
    "Inutile: les combinaisons sont chauffantes!",
    "Inutile: pas de champs magnétique sur la lune!"
  ]
}

test = Test.new(
  name: "Test de la NASA",
  duration: 600,
  description: "Vous faites partie d’un groupe d’astronautes qui a aluni.
  Suite à un problème technique, vous êtes coincés à plus de 300km de votre base.
  Ainsi, pour rejoindre votre base où se trouve la fusée et retourner sur terre, vous devrez classer par ordre de priorité les 15 objets dont vous avez besoin, du haut (indispensable) vers le bas (inutile).",
  solution: solution.to_json
)
test.category_id = Category.find_by_name("logique").id
test.save

puts "All Good Boys"
puts "-------------------------"
