module Dates
  MONTHS_PER_YEAR = 12

  def self.current_date
    DateTime.current
  end

  def self.current_year_end
    1.year.since(current_date).beginning_of_year
  end
end