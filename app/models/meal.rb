class Meal < ActiveRecord::Base

  belongs_to :astronaut
  belongs_to :food

  class << self
    def occurred_between(earlier_date, later_date)
      where('created_at >= :earlier_date AND created_at <= :later_date',
            {:earlier_date => earlier_date, :later_date => later_date})
    end
  end


  def occurred_between?(earlier_time, later_time)
    self.occurred_at >= earlier_time && self.occurred_at < later_time
  end

end
