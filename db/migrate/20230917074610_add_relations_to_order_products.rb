class AddRelationsToOrderProducts < ActiveRecord::Migration[7.0]
  def change
    change_table :order_products do |t|
      t.belongs_to :product, null: false, foreign_key: true
      t.belongs_to :order, null: false, foreign_key: true
    end
  end
end
