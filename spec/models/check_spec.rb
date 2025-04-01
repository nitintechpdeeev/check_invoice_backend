require 'rails_helper'

RSpec.describe Check, type: :model do

  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:check_invoices).dependent(:destroy) }
    it { should have_many(:invoices).through(:check_invoices) }
  end

  describe 'validations' do
    subject { create(:check) }

    it { should validate_presence_of(:number) }
    it { should validate_uniqueness_of(:number).with_message("Check") }
    it { should validate_numericality_of(:number).only_integer.is_greater_than(0).with_message("Check Positive") }
    it { should validate_presence_of(:image) }
  end
end
