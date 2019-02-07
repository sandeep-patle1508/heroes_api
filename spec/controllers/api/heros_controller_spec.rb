require 'rails_helper'

if defined?(ActionController::UrlGenerationError)
  ExpectedRoutingError = ActionController::UrlGenerationError
else
  ExpectedRoutingError = ActionController::RoutingError
end

RSpec.describe Api::HerosController, type: :controller do
  
  before(:each) do
    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/hero/").with(
      headers: {
        'Accept'=>'*/*', 'User-Agent'=>'Ruby'
      }
    ).to_return(
      status: 200, 
      headers: { 'Content-Type': 'application/json' },
      body: File.read('./spec/heros_response.json')
    )

    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/hero/1").with(
      headers: {
        'Accept': '*/*',
        'User-Agent': 'Ruby'
      }
    ).to_return(
      status: 200,
      body: File.read('./spec/hero_response.json'),
      headers: { 'Content-Type': 'application/json' }
    )

    stub_request(:get, "#{ENV['OVERWATCH_BASE_URI']}/hero/1111").with(
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
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    let(:hero_id) { 1 }
    let(:expected_response) { { 'id'=>1, 'name'=>'test', 'real_name'=>'real_name', 'health'=>'health', 'armour'=>'armour', 'shield'=>'shield' } }

    subject { get :show, params: { id: hero_id } }

    context 'when valid hero_id' do
      it 'has a 200 status code' do
        subject    
        expect(response.status).to eq(200)
      end

      it 'responds to GET' do
        subject
        expect(JSON.parse(response.body)).to eq expected_response
      end
    end

    context 'when invalid hero_id' do
      let(:hero_id) { 1111 }
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

    it 'requires the :id parameter' do
      expect { get :show }.to raise_error(ExpectedRoutingError)
    end
  end

  describe 'GET abilities' do
    let(:hero_id) { 1 }
    let(:expected_response) { [{ 'id'=>1, 'name'=>'test', 'description'=>'description', 'is_ultimate'=>'false' }] }

    subject { get :abilities, params: { id: hero_id } }

    it 'has a 200 status code' do
      subject
      expect(response.status).to eq(200)
    end

    it 'responds to GET' do
      subject
      expect(JSON.parse(response.body)).to eq expected_response
    end

    it 'requires the :id parameter' do
      expect { get :show }.to raise_error(ExpectedRoutingError)
    end

  end
end
