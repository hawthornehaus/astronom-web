class Food < ActiveRecord::Base

  DEFAULT_QUANTITY = 50

  has_many :meals

  store_accessor :nutrition, :sodium, :protien # Add more nutrition options here!


  def self.build_from_upc(name: )
    create(
      name: name,
      display_name: name.titleize,
      upc: name,
      quantity: DEFAULT_QUANTITY)
  end


  def self.build_other(name: )
    create(
      name: name,
      display_name: name.titleize,
      quantity: DEFAULT_QUANTITY)
  end

  def nutrients?
      nutr = []

      # sort out units
      nutrient_table = {}

      self.nutrition.each do |n|
          nutrient_name = n[0].chomp("_units")

          nutrient_table[nutrient_name] ||= {}

          if nutrient_name != n[0]
            # handle units measure 
            nutrient_table[nutrient_name]["units"] = n[1]
          else
             #handle amount
            nutrient_table[nutrient_name]["amount"] = n[1]
          end
      end

      nutrient_table.each do |n|
          nutr << n
      end
  end

end
