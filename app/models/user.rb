class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile
  delegate :hired_on, to: :profile

  def has_profile?
    profile.present?
  end

  def pto_hours_available
    PtoCalculator.instance(self).available_hours
  end

  def months_employed
    years_employed = Dates.current_date.year - hired_on.year
    (years_employed * Dates::MONTHS_PER_YEAR) + Dates.current_date.month - hired_on.month
  end

  def first_year?
    months_employed <= Dates::MONTHS_PER_YEAR
  end
end
