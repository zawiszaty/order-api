class OrderSerializer
  include JSONAPI::Serializer
  attributes :id
  has_many :order_products
end
