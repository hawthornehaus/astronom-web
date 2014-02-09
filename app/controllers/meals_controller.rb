class MealsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    meal_event = MealEvent.new(params: params)

    respond_to do |format|
      if meal_event.valid?
        if meal_event.commit!
          format.json { head :created }
          format.html { head :created }
        else
          format.json { head :not_acceptable }
          format.html { head :not_acceptable }
        end
      else
        format.json { head :not_acceptable }
        format.html { head :not_acceptable }
      end
    end
  end

  def new

  end

  def show
    @meals = Meal.all
  end

end
