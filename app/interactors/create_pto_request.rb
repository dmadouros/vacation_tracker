class CreatePtoRequest
  include Interactor

  def call
    pto_request = context.current_user.pto_requests.build(context.pto_request_params)
    unless pto_request.save
      context.fail!(pto_request: pto_request)
    end
  end
end