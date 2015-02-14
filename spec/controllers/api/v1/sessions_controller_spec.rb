require 'rails_helper'

module API
  module V1
    describe SessionsController, :type => :controller do
      let!(:user) do
        create(
          :user,
          email: 'test@example.com',
          password: 'password',
          authentication_token: 'xyz123'
        )
      end

      describe '#create' do
        it 'should present an auth_token for a given user' do
          xhr :post, :create, {email: 'test@example.com', password: 'password'}

          expect(response.code).to eq '200'

          json = JSON.parse(response.body)
          expect(json['auth_token']).to eq 'xyz123'
        end

        context 'when user not found' do
          it 'should return a 404' do
            xhr :post, :create, {email: 'wrong@example.com', password: 'password'}

            expect(response.code).to eq '404'
          end
        end

        context 'when invalid password' do
          it 'should return a 404' do
            xhr :post, :create, {email: 'test@example.com', password: 'wrong'}

            expect(response.code).to eq '404'
          end
        end
      end
    end
  end
end