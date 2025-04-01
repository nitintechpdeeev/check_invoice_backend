require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  describe 'GET #index' do
    let!(:companies) { create_list(:company, 3) }

    it 'returns all companies' do
      get :index
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(companies.first.name)
    end
  end
end
