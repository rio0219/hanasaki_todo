# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Flower.create(name: 'チューリップ', rarity: 'common', image: 'tulip.png', required_count: 5)
Flower.create(name: 'バラ', rarity: 'rare', image: 'rose.png', required_count: 15)
Flower.create(name: 'ひまわり', rarity: 'epic', image: 'sunflower.png', required_count: 30)
