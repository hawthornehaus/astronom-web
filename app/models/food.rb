class Food < ActiveRecord::Base

  DEFAULT_QUANTITY = 50

  has_many :meals

  store_accessor :nutrition, :sodium, :protien # Add more nutrition options here!


  def self.build_from_upc(name: )
    create(
      name: name,
      display_name: name.titleize,
      upc: name,
      quantity: DEFAULT_QUANTITY)
  end


  def self.build_other(name: )
    create(
      name: name,
      display_name: name.titleize,
      quantity: DEFAULT_QUANTITY)
  end

end
