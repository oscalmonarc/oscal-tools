# spec/requests/security_policies_spec.rb
require 'rails_helper'

RSpec.describe 'Security Policy API', type: :request do
  # initialize test data 
  let!(:security_policies) {create_list(:security_policies, 1)}
  let(:security_policy_id) {security_policies.first.id}

  # Test suite for GET /security_policies
  describe 'GET /security_policies' do
    # make HTTP get request before each example
    before {get '/security_policies'}

    it 'returns security_policies' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /security_policies/:id
  describe 'GET /security_policies/:id' do
    before {get "/security_policies/#{security_policy_id}"}

    context 'when the record exists' do
      it 'returns the security_policy' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(security_policy_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:security_policy_id) {100}

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find security_policy/)
      end
    end
  end

  # Test suite for POST /security_policies
  describe 'POST /security_policies' do
    # valid payload
    let(:valid_attributes) {{ org: 'NIST', version: '3', name: 'SP800-53' }}

    context 'when the request is valid' do
      before {post '/security_policies', params: valid_attributes}

      it 'creates a security_policy' do
        expect(json['org']).to eq('NIST')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before {post '/security_policies', params: { org: 'NIST' }}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank and Version can't be blank/)
      end
    end
  end

  # Test suite for PUT /security_policies/:id
  describe 'PUT /security_policies/:id' do
    let(:valid_attributes) {{ name: 'Sp2' }}

    context 'when the record exists' do
      before {put "/security_policies/#{security_policy_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /security_policies/:id
  describe 'DELETE /security_policies/:id' do
    before {delete "/security_policies/#{security_policy_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end