require 'csv'

class NutrientDataImport

  NAME_COLUMN         = 'NDB_No'
  DISPLAY_NAME_COLUMN = 'Shrt_Desc'
  DEFAULT_QUANTITY    = 50

  attr_reader :foodstuffs

  def initialize(usda_records_path: )
    @csv = CSV.open(usda_records_path,
      encoding: 'windows-1251',
      headers:  true)

    @foodstuffs = parse_rows(@csv)
  end


  def commit!
    ActiveRecord::Base.transaction do
      foodstuffs.map(&:save)
    end
  end


  def parse_rows(csv)
    foods = []
    csv.each do |row|
      begin
        # For some reason we might end up with leading zeroes?! Let's stop that.
        name = row[NAME_COLUMN]
        name = name.chars.drop(1).join if name.start_with?('0')

        foods << Food.new(
          name:         name,
          display_name: row[DISPLAY_NAME_COLUMN].gsub(/\,/, ', ').titleize,
          nutrition:    parse_nutrition(row),
          quantity:     DEFAULT_QUANTITY
        )
      rescue
        next
      end
    end
    foods
  end


  def parse_nutrition(row)
    HEADER_SETTINGS.each.with_object({}) do |(name, details), nutrition|
      begin
        if row[name].present?
          nutrition[details[:name]] = row[name].to_i
          nutrition["#{details[:name]}_units"] = details[:units]
        end
      rescue
        next
      end
    end
  end


  def self.units_for(nutrient_name: nutrient_name)
    key, entry = HEADER_SETTINGS.find { |(k, v)| v[:name] == nutrient_name }
    entry[:units]
  end


  HEADER_SETTINGS = {
    'Water_(g)' => {
      name:   'water',
      units:  'g'
    },
    'Energ_Kcal' => {
      name:   'energy',
      units:  'kcal'
    },
    'Protein_(g)' => {
      name:   'protein',
      units:  'g'
    },
    'Lipid_Tot_(g)' => {
      name:   'total_lipid',
      units:  'g'
    },
    'Ash_(g)' => {
      name:   'ash',
      units:  'g'
    },
    'Carbohydrt_(g)' => {
      name:   'carbohydrates',
      units:  'g'
    },
    'Fiber_TD_(g)' => {
      name:   'fiber_td',
      units:  'g'
    },
    'Sugar_Tot_(g)' => {
      name:   'total_sugar',
      units:  'g'
    },
    'Calcium_(mg)' => {
      name:   'calcium',
      units:  'mg'
    },
    'Iron_(mg)' => {
      name:   'iron',
      units:  'mg'
    },
    'Magnesium_(mg)' => {
      name:   'magnesium',
      units:  'mg'
    },
    'Phosphorus_(mg)' => {
      name:   'phosphorus',
      units:  'mg'
    },
    'Potassium_(mg)' => {
      name:   'potassium',
      units:  'mg'
    },
    'Sodium_(mg)' => {
      name:   'sodium',
      units:  'mg'
    },
    'Zinc_(mg)' => {
      name:   'zinc',
      units:  'mg'
    },
    'Copper_mg)' => {
      name:   'copper',
      units:  'mg'
  },
    'Manganese_(mg)' => {
      name:   'maganese',
      units:  'mg'
    },
    'Selenium_(µg)' => {
      name:   'selenium',
      units:  'ug'
    },
    'Vit_C_(mg)' => {
      name:   'vitamin_c',
      units:  'mg'
    },
    'Thiamin_(mg)' => {
      name:   'thiamin',
      units:  'mg'
    },
    'Riboflavin_(mg)' => {
      name:   'riboflavin',
      units:  'mg'
    },
    'Niacin_(mg)' => {
      name:   'niacin',
      units:  'mg'
    },
    'Panto_Acid_mg)' => {
      name:   'panto_acid',
      units:  'mg'
  },
    'Vit_B6_(mg)' => {
      name:   'vitamin_b6',
      units:  'mg'
    },
    'Folate_Tot_(µg)' => {
      name:   'total_folate',
      units:  'ug'
    },
    'Folic_Acid_(µg)' => {
      name:   'folic_acid',
      units:  'ug'
    },
    'Food_Folate_(µg)' => {
      name:   'food_folate',
      units:  'ug'
    },
    'Folate_DFE_(µg)' => {
      name:   'folate_dfe',
      units:  'ug'
    },
    'Choline_Tot_ (mg)' => {
      name:   'total_choline',
      units:  'mg'
    },
    'Vit_B12_(µg)' => {
      name:   'vitamin_b12',
      units:  'ug'
    },
    'Vit_A_IU' => {
      name:   'vitamin_a',
      units:  'iu'
    },
    'Retinol_(µg)' => {
      name:   'retinol',
      units:  'ug'
    },
    'Alpha_Carot_(µg)' => {
      name:   'alpha_carotene',
      units:  'ug'
    },
    'Beta_Carot_(µg)' => {
      name:   'beta_carotene',
      units:  'ug'
    },
    'Beta_Crypt_(µg)' => {
      name:   'beta_cryptoxanthin',
      units:  'ug'
    },
    'Lycopene_(µg)' => {
      name:   'lycopene',
      units:  'ug'
    },
    'Lut+Zea_ (µg)' => {
      name:   'lutein_and_zeaxanthin',
      units:  'ug'
    },
    'Vit_E_(mg)' => {
      name:   'vitamin_e',
      units:  'mg'
    },
    'Vit_D_µg' => {
      name:   'vitamin_d',
      units:  'ug'
    },
    'Vit_K_(µg)' => {
      name:   'vitamin_k',
      units:  'ug'
    },
    'FA_Sat_(g)' => {
      name:   'fat_saturated',
      units:  'g'
    },
    'FA_Mono_(g)' => {
      name:   'fat_monounsaturated',
      units:  'g'
    },
    'FA_Poly_(g)' => {
      name:   'fat_polyunsaturated',
      units:  'g'
    },
    'Cholestrl_(mg)' => {
      name:   'cholesterol',
      units:  'mg'
    }
  }

end
