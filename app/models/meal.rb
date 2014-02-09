class Meal < ActiveRecord::Base

  belongs_to :astronaut
  belongs_to :food

  class << self
    def occurred_between(earlier_date, later_date)
      where('created_at >= :earlier_date AND created_at <= :later_date',
            {:earlier_date => earlier_date, :later_date => later_date})
    end
  end

end
