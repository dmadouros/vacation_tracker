class PageObject
  include Rails.application.routes.url_helpers

  def initialize(driver)
    @driver = driver
  end

  def has_error?
    false
  end

  attr_reader :driver
end