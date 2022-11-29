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
Game.destroy_all if Rails.env.development?
Category.destroy_all if Rails.env.development?

puts "Done"
puts "-------------------------"
puts "Creating Users..."

User.create!(
  username: "Raf",
  email: "raphaeljube@ymail.com",
  password: "secret",
  admin: true
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

@categories = ["logique", "imagination", "optimisation", "sensibilité"]
@categories.each do |category|
  Category.create(name: category)
end

puts "Done"
puts "-------------------------"
puts "Creating Games..."
puts "Game 1"

game = Game.new(
  name: "liste de mots",
  duration: 600,
  description: "Ecrivez un maximum de mots commençant par 'A' et finissant par 'N' (example: 'amidon').",
  solution: "30"
)
game.category_id = Category.find_by_name("imagination").id
game.save
puts "Game 1 OK"


puts "Game 2"
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

game = Game.new(
  name: "test de la NASA",
  duration: 270,
  description: "Vous faites partie d’un groupe d’astronautes qui a aluni.
  Suite à un problème technique, vous êtes coincés à plus de 300km de votre base.
  Ainsi, pour rejoindre votre base où se trouve la fusée et retourner sur terre, vous devrez classer par ordre de priorité les 15 objets dont vous avez besoin, du haut (indispensable) vers le bas (inutile).",
  solution: solution.to_json
)
game.category_id = Category.find_by_name("logique").id
game.save

puts "Game 2 OK"

puts "Game 3"
solution = {
  solutions_list: [
    "joueur",
    "bouleversé",
    "désir",
    "insistant",
    "inquiet",
    "rêveur",
    "mal à l’aise",
    "découragé",
    "préoccupé",
    "prudent",
    "plein de regrets",
    "sceptique",
    "prévoyant",
    "accusateur",
    "contemplatif",
    "songeur",
    "dubitatif",
    "déterminé"
    ],
  proposals_list: [
    ["joueur", "réconfortant", "irrité", "s’ennuyant"],
    ["terrifié", "bouleversé", "arrogant", "agacé"],
    ["blagueur", "angoissé", "désir", "convaincu"],
    ["blagueur", "insistant", "amusé", "détendu"],
    ["irrité", "sarcastique", "inquiet", "amical"],
    ["effondré", "rêveur", "impatient", "alarmé"],
    ["s’excusant", "amical", "mal à l’aise", "démoralisé"],
    ["découragé", "soulagé", "timide", "excité"],
    ["agacé", "hostile", "horrifié", "préoccupé"],
    ["prudent", "insistant", "s’ennuyant", "effondré"],
    ["terrifié", "amusé", "plein de regrets", "charmeur"],
    ["indifférent", "embarrassé", "sceptique", "démoralisé"],
    ["déterminé", "prévoyant", "menaçant", "timide"],
    ["irrité", "déçu", "déprimé", "accusateur"],
    ["contemplatif", "angoissé", "encourageant", "amusé"],
    ["irrité", "songeur", "encourageant", "compatissant"],
    ["dubitatif", "affectueux", "joueur", "effondré"],
    ["déterminé", "amusé", "effondré", "s’ennuyant"]
  ]
}

game = Game.new(
  name: "lecture dans les yeux",
  duration: 270,
  description: "Savez-vous interpréter les émotions dans le regard des gens? Pour chacune des photographies de regards qui suivront, lequel des 4 états d'esprit proposés est exprimé par celle_ci?",
  solution: solution.to_json
)
game.category_id = Category.find_by_name("sensibilité").id
game.save

puts "Game 3 OK"

puts "Game 3bis"
solution = {
  solutions_list: [
    "hésitant",
    "amical",
    "rêveur",
    "préoccupé",
    "provoquant",
    "pensif",
    "intéressé",
    "hostile",
    "prudent",
    "intéressé",
    "réfléchi",
    "charmeur",
    "confiant",
    "sérieux",
    "soucieux",
    "méfiant",
    "nerveux",
    "suspicieux"],
  proposals_list: [
    ["arrogant", "reconnaissant", "sarcastique", "hésitant"],
    ["dominant", "amical", "coupable", "horrifié"],
    ["embarrassé", "rêveur", "confus", "paniqué"],
    ["préoccupé", "reconnaissant", "insistant", "suppliant"],
    ["content", "s’excusant", "provoquant", "curieux"],
    ["pensif", "irrité", "excité", "hostile"],
    ["paniqué", "incrédule", "découragé", "intéressé"],
    ["alarmé", "timide", "hostile", "anxieux"],
    ["blagueur", "prudent", "arrogant", "rassurant"],
    ["intéressé", "blagueur", "affectueux", "content"],
    ["impatient", "effondré", "irrité", "réfléchi"],
    ["reconnaissant", "charmeur", "hostile", "déçu"],
    ["honteux", "confiant", "blagueur", "démoralisé"],
    ["sérieux", "honteux", "bouche bée", "alarmé"],
    ["embarrassé", "coupable", "rêveur", "soucieux"],
    ["effondré", "dérouté", "méfiant", "terrifié"],
    ["perplexe", "nerveux", "insistant", "contemplatif"],
    ["honteux", "nerveux", "suspicieux", "indécis"]
  ]
}

game = Game.new(
  name: "lecture dans les yeux - le retour",
  duration: 270,
  description: "Savez-vous interpréter les émotions dans le regard des gens? Pour chacune des photographies de regards qui suivront, lequel des 4 états d'esprit proposés est exprimé par celle_ci?",
  solution: solution.to_json
)
game.category_id = Category.find_by_name("sensibilité").id
game.save

puts "Game 3bis OK"

puts "Game 4"

game = Game.new(
  name: "pacman",
  description: "Testez votre capacité d'optimisation!
  Vous devez manger tous les fantômes et regagner l'arrivée en utlisant le moins d'actions possibles et le plus rapidement.",
  solution: "N/A"
)
game.category_id = Category.find_by_name("optimisation").id
game.save

puts "game 4 OK"

puts "All Good Boys"
puts "-------------------------"
