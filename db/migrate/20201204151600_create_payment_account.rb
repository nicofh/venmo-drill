class CreatePaymentAccount < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_accounts do |t|
      t.float :balance, null: false, default: 0
      t.references :user, null: false, index: true

      t.timestamps null: false
    end
  end
end
