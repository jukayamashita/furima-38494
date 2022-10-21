FactoryBot.define do
  factory :product do
    association :user

    title { Faker::Name.name }
    introduction { Faker::Lorem.sentence }
    category_id { Faker::Number.between(from: 1, to: 10) }
    condition_id { Faker::Number.between(from: 1, to: 6) }
    delivery_charge_id { Faker::Number.between(from: 1, to: 2) }
    prefecture_id { Faker::Number.between(from: 1, to: 47) }
    days_to_ship_id { Faker::Number.between(from: 1, to: 3) }
    price { Faker::Number.between(from: 300, to: 9_999_999) }

    after(:build) do |product|
      product.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
