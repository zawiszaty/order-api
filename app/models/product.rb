class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 2, maximum: 255 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :thumbnail, presence: true

  has_one_attached :thumbnail
  has_many :order_products
end
