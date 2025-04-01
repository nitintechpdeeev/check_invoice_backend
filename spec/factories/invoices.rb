FactoryBot.define do
  factory :invoice do
    number { rand(1000..9999) }
    company { association :company }
  end
end
