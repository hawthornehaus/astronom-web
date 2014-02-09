class Meal < ActiveRecord::Base

  belongs_to :astronaut
  belongs_to :food

end
