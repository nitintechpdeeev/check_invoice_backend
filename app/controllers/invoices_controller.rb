class InvoicesController < ApplicationController
  def index
    invoices = Invoice.includes(:company, :checks).all

    render json: invoices.as_json(
      include: {
        company: { only: [:id, :name] },
        checks: { only: [:id, :number] }
      }
    )
  end
end
