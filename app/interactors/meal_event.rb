class MealEvent

  attr_reader :params, :errors, :astronaut, :occurred_at, :food

  def initialize(params: )
    params        = extract_params(params)
    @food         = determine_food(params)
    @astronaut    = determine_astronaut(params)
    @occurred_at  = determine_occurred_at(params)
  end


  def valid?
    errors.blank?
  end


  def commit!
    meal = Meal.new(
      astronaut: astronaut,
      food: food,
      occurred_at: occurred_at)
    if valid? && meal.create
      food.decrement!(:quantity)
    end
  end


private #######################################################################


  def extract_params(params)
    params.permit(*allowed_param_keys)
  end


  def allowed_param_keys
    %w[ id source user time ]
  end


  def determine_source(params)
    params.fetch(:source, 'other')
  end


  def determine_astronaut(params)
    name = params.fetch(:user)
    return Astronaut.find_or_create_by(name: name)
  rescue
    add_error('Error determining astronaut.')
  end


  def determine_occurred_at(params)
    Time.parse(params.fetch(:time))
  rescue
    add_error('Error determining time.')
  end


  def determine_food(params)
    food_name   = params.fetch(:id)
    source_type = params.fetch(:source, 'other')
    fetch_food(food_name) || build_food(food_name, source_type)
  rescue
    add_error('Error determining food.')
  end


  def fetch_food(name)
    Food.where(name: name).first
  end


  def build_food(food_name, source_type)
    case source_type
    when 'upc'
      Food.build_from_upc(name: food_name)
    else
      Food.build_other(name: food_name)
    end
  end


  def add_error(error_message)
    @errors ||= []
    @errors << error_message
  end

end
