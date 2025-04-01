FactoryBot.define do
  factory :check do
    number { rand(1000..9999) }
    company { association :company }
    image { Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/test_image.jpg"), "image/png/jpg") }
  end
end
