class MealsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => [:create]

  def create
    meal_event = MealEvent.new(params: params)

    respond_to do |format|
      if meal_event.valid?
        if meal_event.commit!
          format.json { head :created }
          format.html { redirect_to controller: 'meals', action: 'index' }
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
    @meal = Meal.new
    @foods = Food.all
  end

  def show
    @meal = Meal.find(:id=> params[:id])
  end

  def index
      if params[:astro]
      @astro = Astronaut.find_by_name(params[:astro])
      @meals = Meal.where("astronaut_id = ?", @astro.id).order(:occurred_at).page params[:page]
      else
      @meals = Meal.order(:occurred_at).page params[:page]
      end
  end
end
