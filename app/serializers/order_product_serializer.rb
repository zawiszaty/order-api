# frozen_string_literal: true

class OrderProductSerializer
  include JSONAPI::Serializer
  attributes :id, :amount
  attribute :product_name do |object|
    object.product.name
  end
  attribute :product_price do |object|
    object.product.price
  end
  attribute :product_thumbnail_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.product.thumbnail)
  end
  attribute :product_description do |object|
    object.product.description
  end
  has_one :product
end
