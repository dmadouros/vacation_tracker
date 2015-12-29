class UserPresenter < SimpleDelegator
  def initialize(user)
    super(user)
    @user = user
  end

  def pto_requests
    PtoRequestCollection.new(user.pto_requests).pto_requests
  end

  private

  attr_reader :user
end