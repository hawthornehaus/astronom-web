class Food < ActiveRecord::Base
  store_accessor :nutrition, :sodium, :protien # Add more nutrition options here!

end
