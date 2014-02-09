class Snapshot

  attr_reader :start_time, :end_time, :astronaut, :meals,
              :intervals, :interval_in_minutes

  def initialize(params: params)
    params                  = params.permit(*allowed_param_keys)
    @start_time, @end_time  = determine_times(params)
    @astronaut              = determine_astronaut(params)
    @meals                  = determine_meals(@start_time, @end_time)
    @interval_in_minutes    = determine_interval(params)
  end


  def allowed_param_keys
    %w[ name start_time end_time interval_in_minutes ]
  end


  def determine_times(params)
    return  DateTime.parse(params[:start_time]),
            DateTime.parse(params.fetch(:end_time, Time.now.to_s))
  end


  def determine_interval(params)
    Integer(params.fetch(:interval_in_minutes, 1))
  end


  def determine_astronaut(params)
    Astronaut.where(name: params.fetch(:name)).first
  end


  def determine_meals(start_time, end_time)
    Meal
      .where(astronaut_id: astronaut.id)
      .occurred_between(start_time, end_time)
      .order('occurred_at ASC')
      .all.to_a
  end


  def as_json
    build_intervals
    normalize_nutrient_keys
    intervals
  end

  # I definitely could have done this recursively, but you're not the boss of me.
  def build_intervals
    prev_time     = start_time
    current_time  = start_time + interval_in_minutes.minutes
    current_nutrients = {}
    while(current_time <= end_time)
      current_nutrients = nutrients_for_interval(current_nutrients, prev_time, current_time)
      prev_time         = current_time
      current_time     += interval_in_minutes.minutes
    end
  end


  def nutrients_for_interval(current_nutrients, prev_time, current_time)
    updated_nutrients = merge_nutrients(
      current_nutrients,
      fetch_gains(prev_time, current_time),
      fetch_losses(prev_time, current_time))

    store_nutrient_point(current_time, updated_nutrients)
    return updated_nutrients
  end


  def store_nutrient_point(time, nutrients)
    @intervals ||= []
    @intervals << {
      time: time,
      nutrients: nutrients.each.with_object({}) do |(nutrient_name, nutrient_value), result|
        result[nutrient_name] = [nutrient_value, units_for(nutrient_name)]
      end
    }
  end


  def merge_nutrients(current, gains, losses)
    # all_nutrients = Set.new(current.keys + gains.keys + losses.keys)
    all_nutrients = Set.new
    all_nutrients += current.keys
    all_nutrients += gains.keys
    all_nutrients += losses.keys

    all_nutrients.each.with_object({}) do |name, nutrients|
      nutrients[name] =
        current.fetch(name, 0) +
        gains.fetch(name, 0) +
        losses.fetch(name, 0)
    end
  end


  def fetch_gains(earlier_time, later_time)
    meals.select do |meal|
      meal.occurred_at >= earlier_time && meal.occurred_at < later_time
    end.map(&:food).map(&:nutrition).each.with_object({}) do |nutrition, acc|
      # puts nutrition.count
      nutrition.each do |(key, val)|
        unless key.end_with?('_units')
          acc[key] ||= 0
          acc[key] += Integer(val)
        end
      end
    end
  end


  def fetch_losses(earlier_time, later_time)
    # ((later_time - earlier_time) / 60)
    {}
  end



  def normalize_nutrient_keys
    return if intervals.blank? || intervals.last[:nutrients].blank?
    all_keys = intervals.last[:nutrients].keys
    intervals.each do |interval|
      all_keys.each do |key|
        if(interval[:nutrients][key].blank? || interval[:nutrients][key][0].blank?)
          interval[:nutrients][key] = [0, units_for(key)]
        end
      end
    end
  end


  def units_for(nutrient_name)
    NutrientDataImport.units_for(nutrient_name: nutrient_name)
  end

end
