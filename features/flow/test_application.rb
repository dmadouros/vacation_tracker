class TestApplication
  def initialize(driver)
    @driver = driver
  end

  def dashboard_page
    @dashboard_page ||= DashboardPage.new(driver)
  end

  def login_page
    @login_page ||= LoginPage.new(driver)
  end

  def create_profile_page
    @create_profile_page ||= CreateProfilePage.new(driver)
  end

  def create_pto_request_page
    @create_pto_request_page ||= CreatePtoRequestPage.new(driver)
  end

  def edit_profile_page
    @edit_profile_page ||= EditProfilePage.new(driver)
  end

  def notification_section
    @notification_section ||= NotificationSection.new(driver)
  end

  def form_error_section
    @form_error_section ||= FomErrorSection.new(driver)
  end

  def visit_dashboard
    dashboard_page.open
  end

  def login_with_credentials(email:, password:)
    login_page.email = email
    login_page.password = password
    login_page.login
  end

  private

  attr_reader :driver
end