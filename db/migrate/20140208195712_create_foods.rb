class CreateFoods < ActiveRecord::Migration
  def change
    create_table :foods do |t|
      t.string :display_name, null: false
      t.string :upc,          null: false

      t.timestamps
    end
  end
end
