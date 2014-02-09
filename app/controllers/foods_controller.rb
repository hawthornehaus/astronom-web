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

  def show
    params.permit(:id, :format)
    @food = Food.where(id: params[:id]).first

    respond_to do |format|
      format.html { render "show", layout: "callout"}
      format.json { render json: FoodWithNutrition.new(@food).as_json }
    end
  end

  def index
      @foods = Food.order('quantity DESC').all.to_a

      respond_to do |format|
        format.html
      end
  end

end
