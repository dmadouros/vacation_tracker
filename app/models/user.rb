class User < ActiveRecord::Base
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :profile
  has_many :pto_requests
  delegate :hired_on, :pto_hours_used, to: :profile
  validates_associated :profile

  scope :with_profile, -> { where.not(profile_id: nil) }

  def has_profile?
    profile.present?
  end

  def pto_hours_available
    PtoCalculator.instance(self).available_hours
  end

  def pto_hours_accrued
    PtoCalculator.instance(self).accrued_hours
  end

  def months_employed_on(date)
    years_employed = date.year - hired_on.year
    (years_employed * Dates::MONTHS_PER_YEAR) + date.month - hired_on.month
  end

  def first_year?
    months_employed_on(Dates.current_year_end) <= Dates::MONTHS_PER_YEAR
  end

  def pto_hours_requested
    pto_requests.sum(:hours)
  end

  private

  def months_employed
    months_employed_on(Dates.current_date)
  end
end
