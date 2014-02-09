class AddNameToFood < ActiveRecord::Migration
  def change
    add_column :foods, :name, :string, null: false
  end
end
