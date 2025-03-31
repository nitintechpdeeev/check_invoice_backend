class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.integer :number
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
