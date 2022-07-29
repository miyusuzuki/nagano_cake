class CreateOrderInformations < ActiveRecord::Migration[6.1]
  def change
    create_table :order_informations do |t|
      t.integer :customer_id, null: false
      t.string :shipping_postal_code, null: false
      t.string :shipping_address, null: false
      t.string :shipping_name, null: false
      t.integer :postage, null: false
      t.integer :billing_amount, null: false
      t.integer :method_of_payment, null: false, default: 0
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
