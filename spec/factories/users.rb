FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.unique.password(min_length: 6) }
    password_confirmation { password }
    birth_date { Faker::Date.birth_date }
    last_name { '山本' }
    first_name { '太郎' }
    last_name_kana { 'ヤマモト' }
    first_name_kana { 'タロウ' }
    
  end
end