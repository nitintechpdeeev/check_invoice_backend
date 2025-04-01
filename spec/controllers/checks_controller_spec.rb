require 'rails_helper'

RSpec.describe ChecksController, type: :controller do
  describe 'GET #index' do
    let!(:checks) { create_list(:check, 3) }

    it 'returns all checks' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(checks.first.number.to_s)
    end
  end

  describe 'POST #create' do
    let(:company) { create(:company) }
    let(:valid_attributes) { { check: { number: '12345', company_id: company.id, image: fixture_file_upload('test_image.jpg', 'image/jpg'), invoice_numbers: '1, 2' } } }
    let(:invalid_attributes) { { check: { number: nil, company_id: company.id, image: fixture_file_upload('test_image.jpg', 'image/jpg'), invoice_numbers: 'jj, df' } } }

    context 'when valid attributes' do
      it 'creates a new check and associated invoices' do
        expect {
          post :create, params: valid_attributes
        }.to change(Check, :count).by(1)
         .and change(Invoice, :count).by(2)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['check']['number'].to_s).to eq('12345')
      end
    end

    context 'when invalid attributes' do
      it 'does not create a check and returns errors' do
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['number']).to include("can't be blank")
      end

      it 'does not create a check when invoice numbers are not a number and returns errors' do
        invalid_attributes[:check][:number] = '123'
        post :create, params: invalid_attributes
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']['number']).to include("Invoice Positive")
      end
    end
  end
end
