class AddQuantityToFood < ActiveRecord::Migration
  def change
    add_column :foods, :quantity, :integer, null: false, default: 0
  end
end
