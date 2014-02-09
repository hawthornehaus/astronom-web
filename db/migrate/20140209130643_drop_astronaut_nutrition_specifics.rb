class DropAstronautNutritionSpecifics < ActiveRecord::Migration
  def change
    remove_column :astronauts,  :carbohydrates_units
    remove_column :astronauts,  :protein_units
    remove_column :astronauts,  :fats_units
    remove_column :astronauts,  :sodium_units

    remove_column :astronauts,  :carbohydrates
    remove_column :astronauts,  :protein
    remove_column :astronauts,  :fats
    remove_column :astronauts,  :sodium

    change_column :foods,       :upc, :string, null: true
  end
end
