# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
flowers = [
  { name: 'チューリップ', rarity: '1', image: 'tulip.png', required_count: 1 },
  { name: 'ヒマワリ', rarity: '2', image: 'sunflower.png', required_count: 2 },
  { name: 'バラ', rarity: '3', image: 'rose.png', required_count: 3 },
  { name: 'ラン', rarity: '4', image: 'orchid.png', required_count: 4 },
  { name: 'サクラ', rarity: '5', image: 'sakura.png', required_count: 5 }
]

flowers.each do |attrs|
  flower = Flower.find_or_initialize_by(name: attrs[:name])
  flower.update!(attrs) # 既存なら上書き
end