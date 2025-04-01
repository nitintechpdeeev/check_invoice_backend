require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:check_invoices).dependent(:destroy) }
    it { should have_many(:checks).through(:check_invoices) }
  end

  describe 'validations' do
    subject { create(:invoice) }

    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number).with_message("Invoice") }
    it { should validate_numericality_of(:number).only_integer.is_greater_than(0).with_message("Invoice Positive") }
  end
end
