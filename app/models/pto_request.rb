class PtoRequest < ActiveRecord::Base
  belongs_to :user
  validates :start_date, timeliness: {
      after: ->(pto_request) { pto_request.user.hired_on },
      on_or_before: ->(pto_request) { pto_request.end_date },
      type: :date
    }
  validates :end_date, timeliness: {
      after: ->(pto_request) { pto_request.user.hired_on },
      on_or_before: ->(pto_request) { pto_request.start_date.end_of_month },
      on_or_before_message: 'must be in the same month',
      type: :date
    }
  validates :hours, numericality: {
      less_than_or_equal_to: 120,
      greater_than: 0
    }

  def status
    return 'Pending' if pending?
    return 'Completed' if completed?
    return 'In Progress' if in_progress?
  end

  private

  def pending?
    Date.today < start_date
  end

  def completed?
    Date.today > end_date
  end

  def in_progress?
    today = Date.today
    today >= start_date && today <= end_date
  end
end