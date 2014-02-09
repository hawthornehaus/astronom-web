class FoodsController < ApplicationController

  def create
    food = Food.new(params: params)

    respond_to do |format|
      if food.valid?
        if food.commit!
          format.json { head :ok }
        else
          format.json { head :not_acceptable }
        end
      else
        format.json { head :not_acceptable }
      end
    end

  end

  def new
  end 

end
