require 'rails_helper'

RSpec.describe ProfilesController, :type => :controller do

  describe '#new' do

    it 'should render the new page' do
      get :new

      expect(response).to render_template(:new)
    end
  end
end
