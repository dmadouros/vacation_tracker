class PageObject
  include Rails.application.routes.url_helpers

  def initialize(driver, options = {})
    @driver = driver
    after_initialize(options)
  end

  def after_initialize(options)
    #nop
  end

  def has_error?
    false
  end

  attr_reader :driver
end