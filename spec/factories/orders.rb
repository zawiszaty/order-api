FactoryBot.define do
  factory :order do
    order_product { FactoryBot.build_list :order_product, 1 }
  end
end
