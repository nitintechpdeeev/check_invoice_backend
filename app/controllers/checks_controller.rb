class ChecksController < ApplicationController
  def index
    render json: Check.all
  end

  def create
    ActiveRecord::Base.transaction do
      check = Check.new(check_params)

      if check.save
        invoice_numbers = params[:check][:invoice_numbers]&.split(',')&.map(&:strip)

        if invoice_numbers.present?
          invoices = []

          invoice_numbers.each do |num|
            invoice = Invoice.new(number: num, company_id: check.company_id)

            if invoice.save
              invoices << invoice
            else
              raise ActiveRecord::RecordInvalid.new(invoice)
            end
          end

          check.invoices << invoices
        end

        render json: check, status: :created
      else
        raise ActiveRecord::RecordInvalid.new(check)
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    render json: { errors: e.record.errors }, status: :unprocessable_entity
  end

  private

  def check_params
    params.require(:check).permit(:number, :company_id, :image)
  end
end
