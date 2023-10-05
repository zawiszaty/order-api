class AddAmountToOrder < ActiveRecord::Migration[7.0]
  def change
    add_column :order_products, :amount, :integer
  end
end
