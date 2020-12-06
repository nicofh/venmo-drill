class CreatePayment < ActiveRecord::Migration[6.0]
  def change
    create_table :payments do |t|
      t.references :receiver, foreign_key: { to_table: :payment_accounts }, index: true
      t.references :sender, foreign_key: { to_table: :payment_accounts }, index: true
      t.float :amount, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
