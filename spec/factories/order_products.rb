FactoryBot.define do
  factory :order_product do
    association :product
    amount { Faker::Number.between(from: 1, to: 10) }

    trait :with_negative_amount do
      amount { -1 }
    end

    trait :with_zero_amount do
      amount { 0 }
    end
  end
end
