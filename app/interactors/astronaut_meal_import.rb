require 'csv'

class AstronautMealImport

  attr_reader :astronaut, :meal_csv, :meals

  def initialize(astronaut_name: , meal_csv_path: )
    @astronaut  = Astronaut.find_or_create_by(name: astronaut_name)
    @meal_csv   = CSV.open(meal_csv_path,
      headers: true,
      header_converters: ->(h) { h.downcase.underscore })
    @meals = load_meals
  end


  def load_meals
    meal_csv.each.with_object([]) do |meal_row, meals|
      meals << Meal.new(
        astronaut: astronaut,
        food: Food.where(name: meal_row['food_id']).first,
        occurred_at: DateTime.parse(meal_row['time']))
    end
  end


  def commit!
    ActiveRecord::Base.transaction do
      meals.map(&:save)
    end
  end

end