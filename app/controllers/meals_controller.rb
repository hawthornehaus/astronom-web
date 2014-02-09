class MealsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    meal_event = MealEvent.new(params: params)

    respond_do do |format|
      if meal_event.valid?
        if meal_event.commit!
          format.json { head :ok }
        else
          format.json { head :not_acceptable }
        end
      else
        format.json { head :not_acceptable }
      end
    end

  end

end