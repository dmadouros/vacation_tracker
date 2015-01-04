class PtoCalculator
  FIRST_YEAR_ACCRUAL = 80
  SUBSEQUENT_YEARLY_ACCRUAL = 120

  def self.instance(employee)
    if employee.first_year?
      FirstYearPtoCalculator.new(employee)
    else
      MultiYearPtoCalculator.new(employee)
    end
  end

  def available_hours
    raise NotImplementedError
  end

  def annual_accrual
    raise NotImplementedError
  end

  private

  attr_reader :employee

  def initialize(employee)
    @employee = employee
  end

  def monthly_accrual
    Float(annual_accrual) / Dates::MONTHS_PER_YEAR
  end
end


class FirstYearPtoCalculator < PtoCalculator
  def available_hours
    employee.months_employed * monthly_accrual
  end

  def annual_accrual
    FIRST_YEAR_ACCRUAL
  end
end

class MultiYearPtoCalculator < PtoCalculator
  def available_hours
    FIRST_YEAR_ACCRUAL + ((employee.months_employed - Dates::MONTHS_PER_YEAR) * monthly_accrual)
  end

  def annual_accrual
    SUBSEQUENT_YEARLY_ACCRUAL
  end
end