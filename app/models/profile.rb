class Profile < ActiveRecord::Base
  validates :hired_on, timeliness: {:on_or_before => :today, type: :date}
  validates :pto_hours_used, numericality: {
      only_integer: true,
      less_than_or_equal_to: 120,
      greater_than_or_equal_to: 0
    }
end