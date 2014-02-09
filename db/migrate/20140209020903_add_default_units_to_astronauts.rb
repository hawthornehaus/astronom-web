class AddDefaultUnitsToAstronauts < ActiveRecord::Migration
  def change
    change_column :astronauts, :carbohydrates_units, :string,  null: false, default: 'g'
    change_column :astronauts, :protein_units,       :string,  null: false, default: 'g'
    change_column :astronauts, :fats_units,          :string,  null: false, default: 'g'
    change_column :astronauts, :sodium_units,        :string,  null: false, default: 'g'
  end
end
