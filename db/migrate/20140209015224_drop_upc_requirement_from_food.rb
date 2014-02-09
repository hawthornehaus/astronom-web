class DropUpcRequirementFromFood < ActiveRecord::Migration
  def change
    change_column :foods, :upc, :string, null: true
  end
end
