module TheApplication
  def application
    @application ||= TestApplication.new(page)
  end
end

World(TheApplication)