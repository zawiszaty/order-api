class OrderProduct < ApplicationRecord
  belongs_to :product
  belongs_to :order
  validates :amount, presence: true, numericality: { greater_than: 0 }
end
