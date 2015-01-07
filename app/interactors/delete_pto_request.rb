class DeletePtoRequest
  include Interactor

  def call
    current_user = context.current_user
    pto_request_id = context.pto_request_id
    current_user.pto_requests.find(pto_request_id).destroy
  end
end