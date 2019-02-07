require 'rails_helper'

if defined?(ActionController::UrlGenerationError)
  ExpectedRoutingError = ActionController::UrlGenerationError
else
  ExpectedRoutingError = ActionController::RoutingError
end

RSpec.describe Api::AbilitiesController, type: :controller do

  before(:each) do
    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/ability/").with(
      headers: {
        'Accept'=>'*/*',
        'User-Agent'=>'Ruby'
      }
    ).to_return(
      status: 200, 
      headers: { 'Content-Type': 'application/json' },
      body: File.read('./spec/fixtures/abilities_response.json')
    )

    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/ability/1").with(
      headers: {
        'Accept': '*/*',
        'User-Agent': 'Ruby',
       }
      ).to_return(
        status: 200,
        body: File.read('./spec/fixtures/ability_response.json'),
        headers: { 'Content-Type': 'application/json' }
    )

    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/ability/1111").with(
      headers: {
        'Accept': '*/*',
        'User-Agent': 'Ruby',
       }
      ).to_return(
        status: 404,
        body: '{ "error": { "status": "404", "title": "Resource not found"}}',
        headers: { 'Content-Type': 'application/json' }
    )
  end

  describe 'GET index' do

    subject { get :index }

    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    
    let(:expected_response) { { 'id'=>1, 'name'=>'test', 'description'=>'description', 'is_ultimate'=>'false' } }

    subject { get :show, params: { id: ability_id } }

    context 'when valid ability_id' do
      let(:ability_id) { 1 }

      it 'has a 200 status code' do
        subject
        expect(response.status).to eq(200)
      end

      it 'responds to GET' do
        subject
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'when invalid ability_id' do
      let(:ability_id) { 1111 }
      let(:error_response) { { 'error' => 'Not able to find record for this request' } }

      it 'has a 404 status code' do
        subject
        expect(response.status).to eq(404)
      end

      it 'should return empty json' do
        subject
        expect(JSON.parse(response.body)).to eq error_response
      end
    end

    context 'when ability_id not passed' do
      it 'requires the :id parameter' do
        expect { get :show }.to raise_error(ExpectedRoutingError)
      end
    end
  end
end
