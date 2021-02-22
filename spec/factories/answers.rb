# frozen_string_literal: true

FactoryBot.define do
  sequence :body do |n|
    "MyText#{n}"
  end

  factory :answer do
    body
    question { nil }
    author { nil }

    trait :invalid do
      body { nil }
    end
  end
end
