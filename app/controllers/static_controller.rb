class StaticController < ApplicationController

  # landing
  def landing
      respond_to do |format|
        format.html
      end
  end 

  def review
      @astros = Astronaut.all
      respond_to do |format|
        format.html
      end
  end
end
