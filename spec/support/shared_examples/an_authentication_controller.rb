shared_examples_for 'an authenticating controller' do
  context 'when navigating to a url' do
    it 'should redirect to login page' do
      get controller_action

      expect(response).to redirect_to new_user_session_path
    end
  end
end