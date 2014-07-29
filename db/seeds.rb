# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

markets = JSON.parse File.read(Rails.root.join("data", "market.json"))

markets.each do |m|
  if Market.where(code: m["code"]).count == 0
    Market.create(m)
  end
end