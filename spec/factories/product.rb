FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price }
    description { Faker::Lorem.paragraph }
    # thumbnail_url { Faker::Avatar.image }
    after(:build) do |product|
      product.thumbnail.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'thumbnail.jpg')), filename: 'humbnail.jpg', content_type: 'image/jpeg')
    end
  end
end
