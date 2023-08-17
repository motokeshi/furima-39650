FactoryBot.define do
  factory :order_address do
    postal_code   { "#{Faker::Number.number(digits: 3)}-#{Faker::Number.number(digits: 4)}" }
    prefecture_id { rand(2..48) }
    city          { Gimei.address.prefecture.kanji }
    address       { Gimei.address.town.kanji }
    building_name { Faker::Address.building_number }
    phone_number  { Faker::Number.number(digits: 11) }
    token         { "tok_#{Faker::Alphanumeric.alpha(number: 10)}#{Faker::Number.number(digits: 17)}" }
  end
end
