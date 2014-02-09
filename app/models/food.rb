class Food < ActiveRecord::Base
  store_accessor :nutrition, :sodium, :protien # Add more nutrition options here!

  DEFAULT_QUANTITY = 50

  def build_from_upc(name: food_name)
    create(
      name: food_name,
      display_name: food_name.titleize,
      upc: food_name,
      quantity: DEFAULT_QUANTITY)
  end


  def build_other(name: food_name)
    create(
      name: food_name,
      display_name: food_name.titleize,
      quantity: DEFAULT_QUANTITY)
  end

end
