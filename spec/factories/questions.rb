# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { 'MyString' }
    body { 'MyText' }
    author

    trait :invalid do
      title { nil }
    end

    trait :with_files do
      files { [create_file('spec/rails_helper.rb')] }
    end
  end
end
