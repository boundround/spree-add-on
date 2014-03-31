FactoryGirl.define do
  factory :add_on, class: 'Spree::AddOn' do
    amount 4.99
    sequence(:name) { |n| "AddOn ##{n} - #{Kernel.rand(9999)}" }
    expiration_days 30
    description { Faker::Lorem.paragraphs(1).first }
    association :product
  end
end
