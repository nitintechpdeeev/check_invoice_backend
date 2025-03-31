class Check < ApplicationRecord
  belongs_to :company
  has_many :check_invoices, dependent: :destroy
  has_many :invoices, through: :check_invoices

  has_one_attached :image

  validates :number, presence: true, uniqueness: { message: "Check" }, numericality: { only_integer: true, greater_than: 0, message: "Check Positive"  }
  validates :image, presence: true
end
