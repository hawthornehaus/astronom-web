class StaticController < ApplicationController

  # landing
  def landing
      respond_to do |format|
        format.html
      end
  end 
end
