class ProductSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :price
  attribute :thumbnail_url do |object|
    Rails.application.routes.url_helpers.rails_blob_url(object.thumbnail)
  end
end
