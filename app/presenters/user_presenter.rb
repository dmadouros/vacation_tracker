class UserPresenter < SimpleDelegator
  def initialize(user)
    super(user)
    @user = user
  end

  def pto_requests
    user.pto_requests.map do |pto_request|
      PtoRequestPresenter.new(pto_request)
    end
  end

  private

  attr_reader :user
end