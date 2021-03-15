# frozen_string_literal: true

FactoryBot.define do
  sequence :body do |n|
    "MyText#{n}"
  end

  factory :answer do
    body
    question
    author

    trait :invalid do
      body { nil }
    end

    trait :with_files do
      files { [create_file('spec/rails_helper.rb')] }
    end
  end
end
