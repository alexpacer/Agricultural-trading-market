# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
#  sample data produced form
#  mongo 127.0.0.1/www_development --eval "var c = db.markets.find(); while(c.hasNext()){ printjson(c.next()); }" >> markets.json

puts "Seeding Markets"
markets = JSON.parse File.read(Rails.root.join("data", "markets.json"))
markets.each do |m|
  # if Market.where(code: m["code"]).count == 0
  Market.create(m)
  # end
end

puts "Seeding Products"
JSON.parse(File.read(Rails.root.join("data", "products.json"))).each do |p|
  Product.create(p)
end

puts "Seeding Transactions"
JSON.parse(File.read(Rails.root.join("data", "transactions.json"))).each do |t|
  Transaction.create(t)
end
