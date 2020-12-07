class CreateExternalPaymentSource < ActiveRecord::Migration[6.0]
  def change
    create_table :external_payment_sources do |t|
      t.integer :source_type, null: false, default: 0
      t.integer :account, null: false
      t.references :user, null: false, index: true

      t.timestamps null: false
    end
  end
end
