require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  describe 'GET #index' do
    let!(:company) { create(:company) }
    let!(:check) { create(:check, company: company) }
    let!(:invoice) { create(:invoice, company: company) }
    let!(:check_invoice) { create(:check_invoice, invoice: invoice, check: check) }

    it 'returns all invoices with associated company and checks' do
      get :index
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.first['company']['id']).to eq(company.id)
      expect(json_response.first['checks']).to be_an(Array)
      expect(json_response.first['checks'].first['number']).to eq(check.number)
    end
  end
end
