# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

PrepType = [ "Raw", "Cooked", "Boiled", "Baked", "Fried", "Glazed", "Grilled" ]
MeatType = [ "Chicken", "Beef", "Pork", "Human", "Turkey", "Veal", "Spinach", "Artichoke", "Egg" ]
FormType = [ "Soup", "Sandwich", "Salad", "Puree", "Taco", "Stirfry", "Punch", "Surprise" ]

Food.all.to_a.map(&:destroy)

def make_food
    name = "#{PrepType.sample} #{MeatType.sample} #{FormType.sample}"
    upc = Random.rand(999999)
    dname = ["Chef's Favorite ", "Mom's Famous ", "", "Quality "].sample + name + [" Deluxe"," Grande"," de Especial", ""].sample
    quantity = [ Random.rand(50) - 15,0].max
    Food.create(upc:upc, display_name: dname, name:name, quantity: quantity).save
end

50.times do make_food end

