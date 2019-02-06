require 'rails_helper'

if defined?(ActionController::UrlGenerationError)
  ExpectedRoutingError = ActionController::UrlGenerationError
else
  ExpectedRoutingError = ActionController::RoutingError
end

RSpec.describe Api::HerosController, type: :controller do
  describe 'GET index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    let(:user_id) { 1 }

    it 'has a 200 status code' do
      get :show, params: { id: user_id }
      expect(response.status).to eq(200)
    end

    it 'responds to GET' do
      get :show, params: { id: user_id }
      expect(response.body).to eq 'show called'
    end

    it 'requires the :id parameter' do
      expect { get :show }.to raise_error(ExpectedRoutingError)
    end
  end

  describe 'GET abilities' do
    let(:user_id) { 1 }
    subject { get :abilities, params: { id: user_id } }

    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end

    it 'responds to GET' do
      subject
      expect(response.body).to eq 'show called'
    end

    it 'requires the :id parameter' do
      expect { get :show }.to raise_error(ExpectedRoutingError)
    end

  end
end
