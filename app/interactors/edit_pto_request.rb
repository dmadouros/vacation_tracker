class EditPtoRequest
  include Interactor

  def call
    pto_request = context.current_user.pto_requests.find(context.pto_request_id)
    unless pto_request.update_attributes(context.pto_request_params)
      context.fail!(pto_request: pto_request)
    end
  end
end