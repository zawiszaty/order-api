class Order < ApplicationRecord
  has_many :order_product
  # accepts_nested_attributes_for :order_products
end
