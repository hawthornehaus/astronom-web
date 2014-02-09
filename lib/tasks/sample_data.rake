namespace :sample_data do

  task :usda_foods => :environment do
    usda_records    = './db/data/usda_records.csv'
    nutrient_import = NutrientDataImport.new(usda_records_path: usda_records)
    results         = nutrient_import.commit!
    successes       = results.select { |r| r }.count
    puts "Succeeded in creating #{successes} out of #{results} food records."
  end


  task :chris_meals => :environment do
    has_food_id     = ->(m) { m.food_id.present? }
    are_all_true    = ->(b) { b }
    astronaut_name  = 'Chris Ertel'

    meal_import = AstronautMealImport.new(
      astronaut_name: astronaut_name,
      meal_csv_path:  './db/data/chris_ertel.csv')

    if meal_import.meals.map(&has_food_id).all?(&are_all_true)
      results   = meal_import.commit!
      successes = results.select { |r| r }.count
      puts "Succeeded in creating #{successes} out of #{results} meals for Astronaut #{astronaut_name}."
    else
      puts "Meals were note assigned foods for some reason. Did not save meals."
    end
  end

end