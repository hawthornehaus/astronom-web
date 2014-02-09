class ReviewController < ApplicationController

  # review
  def review
        
      @meals = Meal.find(:all)

      respond_to do |format|
        format.html
      end
  end 
end
