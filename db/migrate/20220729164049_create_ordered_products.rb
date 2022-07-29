class CreateOrderedProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :ordered_products do |t|
      t.integer :item_id, null: false
      t.integer :order_informations_id, null: false
      t.integer :price, null: false
      t.integer :amount, null: false
      t.integer :making_status, null: false, default: 0

      t.timestamps
    end
  end
end
