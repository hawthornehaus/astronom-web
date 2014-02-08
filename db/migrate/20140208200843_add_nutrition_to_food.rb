class AddNutritionToFood < ActiveRecord::Migration
  def change
    add_column :foods, :nutrition, :hstore, null: false, default: {}
  end
end
