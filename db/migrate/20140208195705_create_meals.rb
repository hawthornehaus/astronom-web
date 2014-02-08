class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.datetime :occurred_at
      t.integer  :meal_id
      t.integer  :astronaut_id

      t.timestamps
    end
  end
end
