class FixMealForeignKey < ActiveRecord::Migration
  def change
    rename_column :meals, :meal_id, :food_id
  end
end
