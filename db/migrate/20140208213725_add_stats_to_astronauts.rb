class AddStatsToAstronauts < ActiveRecord::Migration
  def change
    add_column :astronauts, :carbohydrates, :integer,       null: false, default: 0
    add_column :astronauts, :protein,       :integer,       null: false, default: 0
    add_column :astronauts, :fats,          :integer,       null: false, default: 0
    add_column :astronauts, :sodium,        :integer,       null: false, default: 0

    add_column :astronauts, :carbohydrates_units, :string,  null: false
    add_column :astronauts, :protein_units,       :string,  null: false
    add_column :astronauts, :fats_units,          :string,  null: false
    add_column :astronauts, :sodium_units,        :string,  null: false

    add_column :astronauts, :points, :integer,              null: false, default: 0
  end
end
