class CheckSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers

  attributes :id, :created_at, :company_name, :number, :invoices, :image

  def company_name
    object.company.name if object.company
  end

  def invoices
    object.invoices.map(&:number)
  end

  def image
    if object.image.attached?
      {
        url: rails_blob_url(object.image, host: Rails.application.config.asset_host || "http://localhost:3000")
      }
    end
  end
end
