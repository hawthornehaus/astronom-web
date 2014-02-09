class InventoryController < ApplicationController

  # inventory
  def inventory

      @foods = Food.find(:all)

      respond_to do |format|
        format.html
      end
  end 
end
