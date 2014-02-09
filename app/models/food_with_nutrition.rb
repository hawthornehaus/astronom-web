class FoodWithNutrition

  attr_reader :food

  def initialize(food)
    @food = food
  end


  def as_json
    food_hash = food.as_json
    food_hash['nutrition'] = parse_nutrients(food_hash['nutrition'])
    food_hash
  end


  def parse_nutrients(nutrients)
    food.nutrition.stringify_keys.map.with_object({}) do |(key, val), parsed_numbers|
      if is_unit?(key)
        parsed_numbers[key] = val
      else
        parsed_numbers[key] = val.to_i
      end
    end
  end


  def is_unit?(str)
    str.end_with?('_unit') ||
      str.end_with?('_units') ||
      str.end_with?('_uom')
  end

end