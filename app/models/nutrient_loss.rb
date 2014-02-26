class NutrientLoss
  include Enumerable

  delegate  :[], :each,
            :to => :loss_table

  attr_reader :from, :to, :gender, :duration_in_seconds, :significance

  def initialize(from: , to: , gender: , significance: 6)
    @gender = gender # currently unused
    @from   = from.to_time
    @to     = to.to_time
    @duration_in_seconds  = ((@to - @from) / 1.seconds).round
    @significance         = significance
  end


  def loss_table
    @loss_table ||= calculate_losses
  end

  alias_method :all, :loss_table


  def calculate_losses
    LOSSES_PER_DAY.each.with_object({}) do |(nutrient, loss_per_day), acc|
      acc[nutrient] = (loss_per_day * (duration_in_seconds / SECONDS_IN_DAY)).round(significance)
    end
  end

  SECONDS_IN_DAY = 86400.0

  LOSSES_PER_DAY = {
    'water'               => 3000.0,
    'energy'              => 3200.0,
    'protein'             => 202.0,
    'total_lipid'         => 54.0,
    # 'ash'                 =>
    'carbohydrates'       => 486.0,
    'fiber_td'            => 43.0,
    'total_sugar'         => 38.0,
    'calcium'             => 1000.0,
    'iron'                => 8.0,
    'magnesium'           => 420.0,
    'phosphorus'          => 700.0,
    'potassium'           => 3000.0,
    'sodium'              => 3000.0,
    'zinc'                => 11.0,
    'copper'              => 900.0,
    'maganese'            => 9.0,
    'selenium'            => 55.0,
    'vitamin_c'           => 90.0,
    'thiamin'             => 1.2,
    'riboflavin'          => 1.3,
    'niacin'              => 16.0,
    'panto_acid'          => 5.0,
    'vitamin_b6'          => 1.3,
    'total_folate'        => 400.0,
    # 'folic_acid'          =>
    # 'food_folate'         =>
    # 'folate_dfe'          =>
    'total_choline'       => 550.0,
    'vitamin_b12'         => 2.4,
    'vitamin_a'           => 900.0,
    'retinol'             => 900.0,
    'alpha_carotene'      => 4.71,
    'vitamin_e'           => 15.0,
    'vitamin_d'           => 5.0,
    'vitamin_k'           => 120.0,
    'fat_saturated'       => 9.0,
    'fat_monounsaturated' => 25.0,
    'fat_polyunsaturated' => 20.0,
    'cholesterol'         => 300.0,
    # 'beta_carotene' =>
    # 'beta_cryptoxanthin' =>
    # 'lycopene' =>
    # 'lutein_and_zeaxanthin' =>
  }

end